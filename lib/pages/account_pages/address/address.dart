import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ontime/pages/account_pages/address/gmap.dart';
import 'package:ontime/pages/home_page/bottom_nav_bar.dart';

class MyAddress extends StatefulWidget {
  final String myAddress;
  const MyAddress({required this.myAddress, super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Home()));
              },
              child: Icon(Icons.home)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.network(
                'https://assets7.lottiefiles.com/packages/lf20_FtD13Z.json',
                repeat: false),
            Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  top: 30,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Your delivery address',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.black,
                        child: IconButton(
                            onPressed: () {
                              print('Clicked');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Gmaps()));
                            },
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            )))
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Container(
                  width: 350,
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 0.5),
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.white,
                      boxShadow: const [BoxShadow(blurRadius: 1.85)]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: [
                        const TextSpan(
                          text: 'Street: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: ' ${widget.myAddress.split(', ')[0]}\n\n',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 16)),
                        const TextSpan(
                          text: 'City: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: ' ${widget.myAddress.split(', ')[1]}\n\n',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 16)),
                        const TextSpan(
                          text: 'Zip code: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' ${widget.myAddress.split(', ')[2]} \n\n',
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const TextSpan(
                          text: 'Country: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' ${widget.myAddress.split(', ')[3]}',
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
