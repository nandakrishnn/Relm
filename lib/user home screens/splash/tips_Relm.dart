import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tips for Relaxation',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15.0),
            _buildTipCard(
              title: 'Find a Quiet Place',
              description:
                  'Choose a quiet environment where you can relax without distractions.',
            ),
            const SizedBox(height: 20.0),
            _buildTipCard(
              title: 'Deep Breathing',
              description:
                  'Practice deep breathing exercises to help calm your mind and body.',
            ),
            const SizedBox(height: 20.0),
            _buildTipCard(
              title: 'Listen to Relaxation Music',
              description:
                  'Explore our collection of relaxation music to help you unwind and de-stress.',
            ),
            const SizedBox(height: 20.0),
            _buildTipCard(
              title: 'Mindfulness Meditation',
              description:
                  'Try mindfulness meditation techniques to focus your attention and relax your body.',
            ),
            const SizedBox(height: 40.0),
            const Text(
              'Benefits of Reading',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            _buildTipCard(
              title: 'Mental Stimulation',
              description:
                  'Reading keeps your brain engaged and can slow down cognitive decline as you age.',
            ),
            const SizedBox(height: 20.0),
            _buildTipCard(
              title: 'Stress Reduction',
              description:
                  'Immersing yourself in a book can help reduce stress levels and promote relaxation.',
            ),
            const SizedBox(height: 20.0),
            _buildTipCard(
              title: 'Knowledge Expansion',
              description:
                  'Reading exposes you to new ideas, cultures, and perspectives, expanding your knowledge and understanding of the world.',
            ),
            const SizedBox(height: 20.0),
            _buildTipCard(
              title: 'Improved Focus and Concentration',
              description:
                  'Regular reading can improve your focus and concentration skills, which can benefit you in other areas of life.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard({required String title, required String description}) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              description,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
