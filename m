Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644084D2947
	for <lists+cgroups@lfdr.de>; Wed,  9 Mar 2022 08:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiCIHLb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Mar 2022 02:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiCIHLa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Mar 2022 02:11:30 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7711D1104
        for <cgroups@vger.kernel.org>; Tue,  8 Mar 2022 23:10:31 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220309071028euoutp01bcb322db18626cb9b6f3ed8dd985d28a~apNBUJ4ER3177831778euoutp01K
        for <cgroups@vger.kernel.org>; Wed,  9 Mar 2022 07:10:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220309071028euoutp01bcb322db18626cb9b6f3ed8dd985d28a~apNBUJ4ER3177831778euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646809828;
        bh=TjJEXRfVW4361xBOm+SseNKtnQiXRSWqUUa3WAQ1Cj8=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=hV4/QhmnUfl4CmIIXt2Ah4Oh1n2aOFiC9nETBVRPgE7NjZcH5ZBSYGE5EA8cv1K/V
         Qb1FUKRdi05wvtvPGH7Cpemxuo9VuxFdc6lgAN6rZ/jAhCcTlpjEzPHZUMeDKnh4El
         ncxX/CCzIkdzCTnx0niXPI0tDCKCAaSGARapk4lo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220309071028eucas1p2c0d00f802cf9672455b62a6a63c12999~apNBFPJ-h0838808388eucas1p2L;
        Wed,  9 Mar 2022 07:10:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 10.68.10260.4E258226; Wed,  9
        Mar 2022 07:10:28 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220309071027eucas1p1f066b42f49e524404d898929b60b344f~apNAyxLdp3267032670eucas1p1I;
        Wed,  9 Mar 2022 07:10:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220309071027eusmtrp12de1cc04d97ba6942d59916713b4cbb8~apNAx7Y0C2066120661eusmtrp1R;
        Wed,  9 Mar 2022 07:10:27 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-d7-622852e4163b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E6.A7.09522.3E258226; Wed,  9
        Mar 2022 07:10:27 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220309071027eusmtip19d569007785921b281798bea93336883~apM--sSZp2204122041eusmtip1k;
        Wed,  9 Mar 2022 07:10:26 +0000 (GMT)
Message-ID: <1be951c7-442f-eb45-a4fc-41fdb771eef7@samsung.com>
Date:   Wed, 9 Mar 2022 08:10:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH linux-next] cgroup: fix suspicious
 rcu_dereference_check() usage warning
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, peterz@infradead.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220305034103.57123-1-zhouchengming@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87pPgjSSDJb2sFrcWD6DxWL1Jl+L
        y7vmsFmceH2EzeLrAS6L470HmCwO3j/HbHH/Yiejxa/lRxktbjZ+YbSYdKOf1YHb49+JNWwe
        h9+8Z/bYOesuu8fmFVoem1Z1snncubaHzWPmWzWPz5vkAjiiuGxSUnMyy1KL9O0SuDKunXrB
        UvCAp2LR78nMDYzXuLoYOTkkBEwkOlrmM3UxcnEICaxglFjRN4EZwvnCKLH4ejs7hPOZUeLl
        kftMMC37bi1jhEgsZ5TYsHwKlPORUeLz4VUsXYwcHLwCdhILLiWCNLAIqEhMn7SNFcTmFRCU
        ODnzCQuILSqQJPHgQB87iC0sECdx8e1TMJtZQFzi1hOIm0QEWhglLlxdwwriMAs8Z5T43tEN
        1s0mYCjR9baLDcTmFHCUWND9iBGiW15i+9s5YE9ICEznlPgxZTnU3S4Sa59dZIOwhSVeHd/C
        DmHLSJye3MMC0dDMKPHw3Fp2CKeHUeJy0wxGiCpriTvnfrGB/MYsoCmxfpc+RNhR4tWa6awg
        YQkBPokbbwUhjuCTmLRtOjNEmFeio00IolpNYtbxdXBrD164xDyBUWkWUsDMQgqAWUjemYWw
        dwEjyypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzANHb63/GvOxhXvPqod4iRiYPxEKME
        B7OSCO/98ypJQrwpiZVVqUX58UWlOanFhxilOViUxHmTMzckCgmkJ5akZqemFqQWwWSZODil
        Gpj0rpatuJ0dYHPAo1pF7rJwaGZ88e9VWxasPb6oIXiB5T9zf8HVwUuObvDK9vR2fcIToCWh
        bu13Psa1S0Rlw56/TCe2/OmbyOb0+43Y63N7Vr1zFZ+86q6Jjee1ua1vPk6a8Ota04Fwx8N1
        0W/StbS6oucc+Z+XuTsj/cXle5vtr5Ypm7Z3xO2f4dZ32lyxf9OehnLBno9xGl5LOu8Jrj31
        12VLu+D/dW+shecyfiu95r7hMCvHoYIN6gFnch6tfPz90bS6TR+FtI90355W+zXesu22wmnr
        gvKeS5/rilicd/Ieu8Jz9ljqa+fSi6pfz5jtX2sn2/Mjz1Gs6fv2bbru6Tv3L39obV73Yi57
        mdFjJZbijERDLeai4kQAq8udptIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xu7qPgzSSDNb361ncWD6DxWL1Jl+L
        y7vmsFmceH2EzeLrAS6L470HmCwO3j/HbHH/Yiejxa/lRxktbjZ+YbSYdKOf1YHb49+JNWwe
        h9+8Z/bYOesuu8fmFVoem1Z1snncubaHzWPmWzWPz5vkAjii9GyK8ktLUhUy8otLbJWiDS2M
        9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DKunXrBUvCAp2LR78nMDYzXuLoYOTkk
        BEwk9t1axtjFyMUhJLCUUeLv309MEAkZiZPTGlghbGGJP9e62CCK3jNKHHi7m6WLkYODV8BO
        YsGlRJAaFgEViemTtoHV8woISpyc+YQFxBYVSJJ4uW0jK0i5sECcxIXpPCBhZgFxiVtP5jOB
        jBQRaGGUmLHoCzOIwyzwnFHi55yZjCBVQgIOEpNunQKz2QQMJbreghzBycEp4CixoPsRI8Qk
        M4murV1QtrzE9rdzmCcwCs1CcscsJAtnIWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k
        /NxNjMCY3Xbs5+YdjPNefdQ7xMjEwXiIUYKDWUmE9/55lSQh3pTEyqrUovz4otKc1OJDjKbA
        wJjILCWanA9MGnkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUx1
        p9Z9ULzKMo9v1vPdLCl8V694BP1ZEVmoxbQlPrpx8uTphn7BDFemzTqg2nc+L1z22T4jueXt
        8/5uF251cfBhyvn45vfZuJDtfxinC/ScSW83Toh7H/C74LnSofo9MQlqn+vcw6dxrN1v+9Oa
        u9Irvfx80DOONx6F++71HTlknC1kqDXlZdCOA2q/nuk7rS7USC0+rFxw2v/6J22/7DDl3C+l
        4cFmTkK3d7N+bpslunelS1Gg5kaWa/wfn77zOME/504979yEnZdUbmlxhSWs/BKz6nPcn9rk
        ZYvOV/3ZdnN1rlpk+uU7OoFqf9qmT7kV4eN1XV3gsuuPC9+Lss/tWPNt/lyFSu2qcP7fiXFK
        LMUZiYZazEXFiQAdyppPYgMAAA==
X-CMS-MailID: 20220309071027eucas1p1f066b42f49e524404d898929b60b344f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220309071027eucas1p1f066b42f49e524404d898929b60b344f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220309071027eucas1p1f066b42f49e524404d898929b60b344f
References: <20220305034103.57123-1-zhouchengming@bytedance.com>
        <CGME20220309071027eucas1p1f066b42f49e524404d898929b60b344f@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 05.03.2022 04:41, Chengming Zhou wrote:
> task_css_set_check() will use rcu_dereference_check() to check for
> rcu_read_lock_held() on the read-side, which is not true after commit
> dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock"). This
> commit drop explicit rcu_read_lock(), change to RCU-sched read-side
> critical section. So fix the RCU warning by adding check for
> rcu_read_lock_sched_held().
>
> Fixes: dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com
> Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Right, this fixes the issue I've reported here:

https://lore.kernel.org/all/f4bc652b-115f-35b5-91db-bad3b30fed9b@samsung.com/

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   include/linux/cgroup.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 1e356c222756..0d1ada8968d7 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -450,6 +450,7 @@ extern struct mutex cgroup_mutex;
>   extern spinlock_t css_set_lock;
>   #define task_css_set_check(task, __c)					\
>   	rcu_dereference_check((task)->cgroups,				\
> +		rcu_read_lock_sched_held() ||				\
>   		lockdep_is_held(&cgroup_mutex) ||			\
>   		lockdep_is_held(&css_set_lock) ||			\
>   		((task)->flags & PF_EXITING) || (__c))

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

