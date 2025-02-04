import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  ScrollView,
  Modal,
  StyleSheet,
} from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { Picker } from '@react-native-picker/picker';
import Slider from '@react-native-community/slider';
// import AsyncStorage from '@react-native-async-storage/async-storage'; // for persistence if desired

// A simple mapping for restriction types
const RestrictionType = {
  none: 'none',
  wait: 'wait',
  mathQuestion: 'mathQuestion',
};

const Customize = () => {
  // Similar state variables as in SwiftUI
  const [editingRestriction, setEditingRestriction] = useState(null); // { appKey, index, rule }
  const [appName, setAppName] = useState('');
  const [createdRestrictions, setCreatedRestrictions] = useState({}); // e.g. { "tiktok": [ { ...rule }, ... ] }
  const [showLevels, setShowLevels] = useState(false);
  const [addAppRestriction, setAddAppRestriction] = useState(false);
  const [selectedType, setSelectedType] = useState('None');
  const [timeWait, setTimeWait] = useState('5s');
  const [difficultyMathQuestion, setDifficultyMathQuestion] = useState('Easy');
  const [tester, setTester] = useState(0.5);

  // Other constants:
  const options = ['None', 'Time', 'Math Question'];
  const questions = ['Easy', 'Moderate', 'Hard', 'Extreme', 'Engineer'];
  const times = ['5s', '10s', '20s', '30s', '1m'];

  // You could load/save restrictions with AsyncStorage here if desired:
  useEffect(() => {
    // loadRestrictions();
  }, []);

  const saveRestrictions = async () => {
    // AsyncStorage.setItem('savedRestrictions', JSON.stringify(createdRestrictions));
  };

  // A helper to update a restriction (handles app name changes)
  const updateRestriction = (original, updatedRule, newAppKey) => {
    setCreatedRestrictions(prev => {
      let newRestrictions = { ...prev };
      if (newAppKey === original.appKey) {
        newRestrictions[newAppKey][original.index] = updatedRule;
      } else {
        newRestrictions[original.appKey].splice(original.index, 1);
        if (newRestrictions[original.appKey].length === 0) {
          delete newRestrictions[original.appKey];
        }
        if (!newRestrictions[newAppKey]) {
          newRestrictions[newAppKey] = [];
        }
        newRestrictions[newAppKey].push(updatedRule);
      }
      // Optionally, saveRestrictions();
      return newRestrictions;
    });
  };

  // Helper to parse wait time from a string like "5s" or "1m"
  const parseWaitTime = (timeString) => {
    if (timeString.endsWith('s')) {
      return parseInt(timeString.slice(0, -1));
    } else if (timeString === '1m') {
      return 60;
    }
    return null;
  };

  // Render a simple background and gradient (similar to your SwiftUI views)
  const Background = () => <View style={styles.background} />;
  const PurpleGradient = ({ children }) => (
    <LinearGradient
      colors={['rgba(0,0,255,0.75)', 'rgba(128,0,128,0.8)']}
      style={styles.gradient}
    >
      {children}
    </LinearGradient>
  );

  // A placeholder for your "bubbles" view (using an emoji here)
  const Bubbles = () => (
    <Text style={styles.bubbles}>✨</Text>
  );

  // Render a single restriction item.
  const renderRestrictionItem = (rule, appKey, index) => (
    <TouchableOpacity
      key={index}
      onPress={() => setEditingRestriction({ appKey, index, rule })}
    >
      <View style={styles.restrictionItem}>
        <Text style={styles.restrictionTitle}>
          {rule.appName || 'Unknown App'}
        </Text>
        <View style={styles.restrictionRow}>
          <Text style={styles.restrictionText}>Type: {rule.restrictionType}</Text>
          <Text style={styles.restrictionText}>Threshold: {rule.threshold}</Text>
        </View>
        {rule.restrictionType === RestrictionType.wait ? (
          <Text style={styles.restrictionText}>Wait Time: {rule.waitTime} seconds</Text>
        ) : rule.restrictionType === RestrictionType.mathQuestion ? (
          <Text style={styles.restrictionText}>
            Math Difficulty: {rule.mathQuestionDifficulty}
          </Text>
        ) : (
          <Text style={[styles.restrictionText, { opacity: 0.4 }]}>
            No Additional Restriction
          </Text>
        )}
      </View>
    </TouchableOpacity>
  );

  return (
    <View style={{ flex: 1 }}>
      <Background />
      <ScrollView contentContainerStyle={styles.container}>
        <Text style={styles.header}>Restriction Set Up</Text>
        {Object.keys(createdRestrictions).length === 0 ? (
          <View style={styles.emptyContainer}>
            <Bubbles />
            <Text style={styles.emptyText}>
              You currently have no restrictions. Would you like to add some?
            </Text>
          </View>
        ) : (
          Object.keys(createdRestrictions)
            .sort()
            .map(appKey => (
              <View key={appKey}>
                <Text style={styles.sectionHeader}>{appKey}</Text>
                {createdRestrictions[appKey].map((rule, index) =>
                  renderRestrictionItem(rule, appKey, index)
                )}
              </View>
            ))
        )}
        <TouchableOpacity
          style={styles.button}
          onPress={() => {
            setShowLevels(true);
            setAddAppRestriction(true);
          }}
        >
          <Text style={styles.buttonText}>Customize</Text>
        </TouchableOpacity>
      </ScrollView>

      {/* Modal for editing a restriction */}
      <Modal
        visible={!!editingRestriction}
        animationType="slide"
        transparent
      >
        {editingRestriction && (
          <EditRestrictionView
            editing={editingRestriction}
            onSave={(updatedRule, updatedAppKey) => {
              updateRestriction(editingRestriction, updatedRule, updatedAppKey);
              setEditingRestriction(null);
            }}
            onCancel={() => setEditingRestriction(null)}
          />
        )}
      </Modal>

      {/* Modal for adding an app restriction */}
      <Modal visible={addAppRestriction} animationType="slide" transparent>
        <View style={styles.modalContainer}>
          <View style={styles.modalContent}>
            <Text style={styles.modalHeader}>Select App to Restrict</Text>
            <Text style={styles.modalSubHeader}>
              Enter the name of the app you would like to set a screen-time restriction for.
            </Text>
            <TextInput
              style={styles.input}
              placeholder="e.g. TikTok"
              placeholderTextColor="#ccc"
              value={appName}
              onChangeText={setAppName}
            />
            <View style={styles.modalButtons}>
              <TouchableOpacity
                style={[styles.modalButton, { backgroundColor: 'red' }]}
                onPress={() => {
                  setAppName('');
                  setAddAppRestriction(false);
                  setShowLevels(false);
                }}
              >
                <Text style={styles.modalButtonText}>Cancel</Text>
              </TouchableOpacity>
              <TouchableOpacity
                style={[styles.modalButton, { backgroundColor: 'green' }]}
                onPress={() => {
                  setAddAppRestriction(false);
                  setShowLevels(true);
                }}
              >
                <Text style={styles.modalButtonText}>Next</Text>
              </TouchableOpacity>
            </View>
          </View>
        </View>
      </Modal>

      {/* Modal for choosing a restriction */}
      <Modal visible={showLevels} animationType="slide" transparent>
        <View style={styles.modalContainer}>
          <ScrollView contentContainerStyle={styles.modalContent}>
            <Text style={styles.modalHeader}>Choose Restriction</Text>
            <View style={styles.fieldContainer}>
              <Text style={styles.fieldLabel}>Type</Text>
              <Picker
                selectedValue={selectedType}
                style={styles.picker}
                onValueChange={(itemValue) => setSelectedType(itemValue)}
              >
                {options.map(option => (
                  <Picker.Item key={option} label={option} value={option} />
                ))}
              </Picker>
            </View>
            <View style={styles.fieldContainer}>
              <Text style={styles.fieldLabel}>Threshold: {Math.round(tester)}</Text>
              <Slider
                style={{ width: '100%', height: 40 }}
                minimumValue={0}
                maximumValue={25}
                step={1}
                value={tester}
                onValueChange={setTester}
                minimumTrackTintColor="purple"
                maximumTrackTintColor="#000000"
              />
            </View>
            {selectedType === 'Time' && (
              <View style={styles.fieldContainer}>
                <Text style={styles.fieldLabel}>How long do you want to wait?</Text>
                <Picker
                  selectedValue={timeWait}
                  style={styles.picker}
                  onValueChange={(itemValue) => setTimeWait(itemValue)}
                >
                  {times.map(time => (
                    <Picker.Item key={time} label={time} value={time} />
                  ))}
                </Picker>
              </View>
            )}
            {selectedType === 'Math Question' && (
              <View style={styles.fieldContainer}>
                <Text style={styles.fieldLabel}>What difficulty math question would you like?</Text>
                <Picker
                  selectedValue={difficultyMathQuestion}
                  style={styles.picker}
                  onValueChange={(itemValue) => setDifficultyMathQuestion(itemValue)}
                >
                  {questions.map(question => (
                    <Picker.Item key={question} label={question} value={question} />
                  ))}
                </Picker>
              </View>
            )}
            <View style={styles.modalButtons}>
              <TouchableOpacity
                style={[styles.modalButton, { backgroundColor: 'red' }]}
                onPress={() => setShowLevels(false)}
              >
                <Text style={styles.modalButtonText}>Cancel</Text>
              </TouchableOpacity>
              <TouchableOpacity
                style={[styles.modalButton, { backgroundColor: 'green' }]}
                onPress={() => {
                  const rType =
                    selectedType === 'Time'
                      ? RestrictionType.wait
                      : selectedType === 'Math Question'
                      ? RestrictionType.mathQuestion
                      : RestrictionType.none;
                  const thresholdVal = Math.round(tester);
                  const computedWaitTime = rType === RestrictionType.wait ? parseWaitTime(timeWait) : null;
                  const newRule = {
                    appName: appName === '' ? 'Default App' : appName,
                    restrictionType: rType,
                    threshold: thresholdVal,
                    waitTime: computedWaitTime,
                    mathQuestionDifficulty:
                      rType === RestrictionType.mathQuestion ? difficultyMathQuestion : null,
                  };
                  const key = (appName === '' ? 'Default App' : appName).toLowerCase();
                  setCreatedRestrictions(prev => ({
                    ...prev,
                    [key]: prev[key] ? [...prev[key], newRule] : [newRule],
                  }));
                  saveRestrictions();
                  setAppName('');
                  setShowLevels(false);
                }}
              >
                <Text style={styles.modalButtonText}>Confirm</Text>
              </TouchableOpacity>
            </View>
          </ScrollView>
        </View>
      </Modal>
    </View>
  );
};

// An EditRestrictionView component similar in purpose to your SwiftUI version.
const EditRestrictionView = ({ editing, onSave, onCancel }) => {
  const [localAppName, setLocalAppName] = useState(editing.rule.appName || editing.appKey);
  const [localSelectedType, setLocalSelectedType] = useState(() => {
    if (editing.rule.restrictionType === RestrictionType.wait) return 'Time';
    if (editing.rule.restrictionType === RestrictionType.mathQuestion) return 'Math Question';
    return 'None';
  });
  const [localThreshold, setLocalThreshold] = useState(editing.rule.threshold);
  const [localTimeWait, setLocalTimeWait] = useState(editing.rule.waitTime ? `${editing.rule.waitTime}s` : '5s');
  const [localDifficulty, setLocalDifficulty] = useState(editing.rule.mathQuestionDifficulty || 'Easy');

  const options = ['None', 'Time', 'Math Question'];
  const questions = ['Easy', 'Moderate', 'Hard', 'Extreme', 'Engineer'];

  const parseWaitTime = (timeString) => {
    if (timeString.endsWith('s')) {
      return parseInt(timeString.slice(0, -1));
    } else if (timeString === '1m') {
      return 60;
    }
    return null;
  };

  return (
    <View style={styles.modalContainer}>
      <ScrollView contentContainerStyle={styles.modalContent}>
        <Text style={styles.modalHeader}>Edit Restriction</Text>
        <View style={styles.fieldContainer}>
          <Text style={styles.fieldLabel}>App Name</Text>
          <TextInput
            style={styles.input}
            value={localAppName}
            onChangeText={setLocalAppName}
            placeholder="Enter app name"
            placeholderTextColor="#ccc"
          />
        </View>
        <View style={styles.fieldContainer}>
          <Text style={styles.fieldLabel}>Type</Text>
          <Picker
            selectedValue={localSelectedType}
            style={styles.picker}
            onValueChange={(itemValue) => setLocalSelectedType(itemValue)}
          >
            {options.map(option => (
              <Picker.Item key={option} label={option} value={option} />
            ))}
          </Picker>
        </View>
        <View style={styles.fieldContainer}>
          <Text style={styles.fieldLabel}>Threshold: {localThreshold}</Text>
          <Slider
            style={{ width: '100%', height: 40 }}
            minimumValue={0}
            maximumValue={25}
            step={1}
            value={localThreshold}
            onValueChange={setLocalThreshold}
            minimumTrackTintColor="purple"
            maximumTrackTintColor="#000000"
          />
        </View>
        {localSelectedType === 'Time' && (
          <View style={styles.fieldContainer}>
            <Text style={styles.fieldLabel}>Wait Time</Text>
            <Picker
              selectedValue={localTimeWait}
              style={styles.picker}
              onValueChange={(itemValue) => setLocalTimeWait(itemValue)}
            >
              {['5s', '10s', '20s', '30s', '1m'].map(time => (
                <Picker.Item key={time} label={time} value={time} />
              ))}
            </Picker>
          </View>
        )}
        {localSelectedType === 'Math Question' && (
          <View style={styles.fieldContainer}>
            <Text style={styles.fieldLabel}>Math Difficulty</Text>
            <Picker
              selectedValue={localDifficulty}
              style={styles.picker}
              onValueChange={(itemValue) => setLocalDifficulty(itemValue)}
            >
              {questions.map(question => (
                <Picker.Item key={question} label={question} value={question} />
              ))}
            </Picker>
          </View>
        )}
        <View style={styles.modalButtons}>
          <TouchableOpacity
            style={[styles.modalButton, { backgroundColor: 'red' }]}
            onPress={onCancel}
          >
            <Text style={styles.modalButtonText}>Cancel</Text>
          </TouchableOpacity>
          <TouchableOpacity
            style={[styles.modalButton, { backgroundColor: 'green' }]}
            onPress={() => {
              const newType =
                localSelectedType === 'Time'
                  ? RestrictionType.wait
                  : localSelectedType === 'Math Question'
                  ? RestrictionType.mathQuestion
                  : RestrictionType.none;
              const computedWaitTime = newType === RestrictionType.wait ? parseWaitTime(localTimeWait) : null;
              const updatedRule = {
                appName: localAppName,
                restrictionType: newType,
                threshold: localThreshold,
                waitTime: computedWaitTime,
                mathQuestionDifficulty:
                  newType === RestrictionType.mathQuestion ? localDifficulty : null,
              };
              onSave(updatedRule, localAppName);
            }}
          >
            <Text style={styles.modalButtonText}>Save</Text>
          </TouchableOpacity>
        </View>
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  background: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: 'black',
  },
  gradient: {
    ...StyleSheet.absoluteFillObject,
  },
  bubbles: {
    fontSize: 144,
    fontWeight: '900',
    color: 'white',
    textAlign: 'center',
  },
  container: {
    padding: 20,
    paddingBottom: 60,
  },
  header: {
    fontSize: 24,
    fontWeight: 'bold',
    color: 'white',
    textAlign: 'center',
    marginVertical: 20,
  },
  emptyContainer: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  emptyText: {
    color: 'white',
    textAlign: 'center',
    marginTop: 20,
  },
  sectionHeader: {
    fontSize: 20,
    color: 'white',
    marginTop: 20,
  },
  restrictionItem: {
    backgroundColor: 'rgba(255,255,255,0.1)',
    borderRadius: 12,
    padding: 15,
    marginVertical: 5,
  },
  restrictionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: 'white',
  },
  restrictionRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 5,
  },
  restrictionText: {
    color: 'white',
    opacity: 0.8,
  },
  button: {
    backgroundColor: 'purple',
    padding: 15,
    borderRadius: 10,
    marginTop: 20,
  },
  buttonText: {
    color: 'white',
    fontSize: 18,
    textAlign: 'center',
  },
  modalContainer: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.7)',
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  modalContent: {
    backgroundColor: 'black',
    padding: 20,
    borderRadius: 12,
    width: '100%',
  },
  modalHeader: {
    fontSize: 22,
    color: 'white',
    textAlign: 'center',
    marginBottom: 20,
  },
  modalSubHeader: {
    color: 'white',
    textAlign: 'center',
    marginBottom: 20,
  },
  input: {
    backgroundColor: 'rgba(255,255,255,0.2)',
    color: 'white',
    borderRadius: 8,
    padding: 10,
    marginBottom: 20,
  },
  modalButtons: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  modalButton: {
    padding: 10,
    borderRadius: 8,
    width: '40%',
    alignItems: 'center',
  },
  modalButtonText: {
    color: 'white',
    fontWeight: 'bold',
  },
  fieldContainer: {
    marginBottom: 15,
  },
  fieldLabel: {
    color: 'white',
    marginBottom: 5,
  },
  picker: {
    backgroundColor: 'rgba(255,255,255,0.2)',
    color: 'white',
  },
});

export default Customize;
