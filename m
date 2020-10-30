Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE742A063F
	for <lists+cgroups@lfdr.de>; Fri, 30 Oct 2020 14:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgJ3NLf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Oct 2020 09:11:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50238 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3NLf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Oct 2020 09:11:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UD5Cm1040754;
        Fri, 30 Oct 2020 13:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=P4mtStT2D2qnh4vVbPD791lmQ3o57FSAUHJXBvfRArk=;
 b=tdQ33e24t9bxSOVk27NNg8uJUHv0y2qs10GHQLEWt8+YFsE/EDrJ+GqzOcYh/SC7EA5p
 UldB+zXykFrU/rrTe7RkWO6UCqtmA1LbyyRAEOLG93RKlhrJfm4fHZ4YM4NYM0IKDLZZ
 pTH/tM4mpRtCtWsoy+wS9w0hhihOHacfQGQTSnTrzH7iMtiFXq4jnPT/2/7ovBGsJuTu
 W2n39wO1ecOOwq92pOqWqmPlTbAbK1DNxrL8UAIt0h+61UG1Y6GGJQ2K5/rf9MYF9tpR
 4ASde0iGGosNaYdfJSDdSSiV6ybWybe4l9J3iabvlSLRjO5Bea07tAdAuCv+QjSIjumx +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34cc7m9m1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 13:11:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UD6C1n129781;
        Fri, 30 Oct 2020 13:11:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34cx61pdx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 13:11:29 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09UDBRPP007339;
        Fri, 30 Oct 2020 13:11:28 GMT
Received: from OracleT490.vogsphere (/73.203.30.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Oct 2020 06:11:27 -0700
Subject: Re: [QUESTION] Cgroup namespace and cgroup v2
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org
References: <d223c6ba-9fcf-8728-214b-1bce30f26441@oracle.com>
 <20201027182659.GA62134@blackbook>
From:   Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <001e7b1d-1b7c-e3d8-493f-2b78b3b093b1@oracle.com>
Date:   Fri, 30 Oct 2020 07:11:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027182659.GA62134@blackbook>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300098
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/27/20 12:26 PM, Michal Koutný wrote:
> Hi Tom.
>
> On Tue, Oct 20, 2020 at 03:12:28PM -0600, Tom Hromatka <tom.hromatka@oracle.com> wrote:
>> But this fails on a cgroup v2 system in a
>> cgroup namespace because the root cgroup is a non-leaf cgroup.
> Yes, the no internal process constraint simplifies and enables many
> things for v2 controllers.
>
>> * As outlined above, the behavior of the "root" cgroup in a cgroup
>>    namespace on a v2 system differs from the behavior of the
>>    unnamespaced root cgroup.  At best this is inconsistent; at worst,
>>    this may leak information to an unethical program.
> What information does this leak? (That it's running in a cgroup namespace?)
> Note that this isn't the only discrepancy between host root cgroup and
> namespaced root cgroup. The host group is simply special.

Oops.  My wording was overly dramatic.  My in-house customers
get nervous when things differ within a container vs. on a host.

You're right, it differs, but that's an acceptable side effect
of the improved design of cgroup v2.

Would you mind sharing some of the other discrepancies?  I
would like to be prepared when we run into them as well.

Thanks!

>
>>    Any ideas how   we can make the behavior more consistent for the
>> user and   libcgroup?
> You can disable the controllers (via parent's cgroup.subtree_control) to
> allow migration into the parent. Of course that affects also siblings of
> the removed cgroup.

Good call.  I didn't think of that.

>
>> * I will likely add a flag to cgdelete to simply kill processes in
>>    a cgroup rather than try and move them to the parent cgroup.
>>    Moving processes to the parent cgroup is somewhat challenging
>>    even in a cgroup v1 system due to permissions, etc.
> In general, migrations with controlled v2 cgroup are not supported, so
> moving processes up and (especially) down has less sense than in v1.
> Hence, refusing the delete operation on a populated cgroup (with
> controllers) is IMO justified.

That makes a lot of sense.  I think I will need to spend
time with the database team and others.  Cgroup v2 is simply
different enough that we'll need to rethink some of the
decisions that were made for cgroup v1.

Thanks so much for the help.

Tom

>
>
> Michal

