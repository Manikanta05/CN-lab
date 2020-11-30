import java.util.Scanner; 
public class rsa
{
public static void main(String[] args)
{
Main rsa=new Main(); 
int p = 0,q = 0;
Scanner in=new Scanner(System.in); System.out.println("Enter the message to be encrypted: "); String message=in.nextLine();
char[] msgA=message.toCharArray(); boolean check=false;
while(!check)
{
System.out.println("Enter two prime numbers: "); p=in.nextInt();
q=in.nextInt();
if(checkPrime(p) && checkPrime(q)) check=true;
}
int n=p*q;
int z=(p-1)*(q-1); int e = 0;
for(int i=2;i<z;i++)
{
if(rsa.gcd(i,z)==1)
{
e=i; break;
}
}
System.out.println("The value of e: "+e); System.out.println("Public key: ("+e+", "+n+")"); int d=0;
for(d=2;d<z;d++)
if((e*d)%z==1)
break; System.out.println("d: "+d); int ch;
int[] a=new int[message.length()]; int[] c=new int[message.length()]; int t=0;
for(int i=0;i<message.length();i++)
 
{
ch=(int)msgA[i]; a[i]=ch;
t=1;
for(int j=0;j<e;j++)
t=(t*ch)%n;
c[i]=t;
}
System.out.println("Message ASCII Cipher"); for(int i=0;i<message.length();i++)
System.out.println(" "+msgA[i]+"\t "+a[i]+"\t "+c[i]); char cha[]=new char[message.length()]; System.out.println("Decrypting...");
for(int i=0;i<message.length();i++)
{
ch=c[i]; t=1;
for(int j=0;j<d;j++)
t=(t*ch)%n; cha[i]=(char)t;
}
System.out.println(new String(cha));
}
public int gcd(int a,int b)
{
if(b==0)
return a; return gcd(b,a%b);
}
public static boolean checkPrime(int num1)
{
if(num1==0 || num1==1)
return false; else if(num1==2)
return true; for(int i=2;i<num1;i++)
if(num1%i==0)
return false;
return true;
}
}
