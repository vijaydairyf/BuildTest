using Android.OS;
using Android.Views;
using Distributr.Mobile.Login;
using Mobile.Common;

namespace Distributr.Mobile.MakeOrder
{
    public class MakeOrderFragment : BaseFragment<User>
    {
        public override void CreateChildViews(View parent, Bundle bundle)
        {
            SetTitle(Resource.String.make_order);
        }
    }
}