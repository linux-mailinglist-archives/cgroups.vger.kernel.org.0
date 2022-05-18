Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE2352C375
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 21:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241879AbiERT3A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 15:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiERT26 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 15:28:58 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770FE1BDD8D
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 12:28:56 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220518192853euoutp014fd10f3d91ffa3d723ca4c45f39ac22d~wSbuuD97C1982019820euoutp01d
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 19:28:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220518192853euoutp014fd10f3d91ffa3d723ca4c45f39ac22d~wSbuuD97C1982019820euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652902133;
        bh=rU7RXbbuzPE5V8CNvE+sIgl9BA3+n1vzQusFXegX7JE=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=lQ4rv4GqBuOGUpx7R0uiGuRSUbw5/PHhkCQfdv2rkxG0HlDscthUY8MiWV28MwpEH
         sH7bVBBhsTAaspzk02Hqm6BORH03WKNeSWec61jyXspV34RveaxpVY9v3e9OT/3GKH
         MsKo6ySanhnPiME+PWSw+J8BLQIN7nc2HfLtkBiE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220518192852eucas1p1a71e2c510f9af7afc3866f84824e68f0~wSbttd8ht0040000400eucas1p1T;
        Wed, 18 May 2022 19:28:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1E.2C.10260.4F845826; Wed, 18
        May 2022 20:28:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220518192850eucas1p1458c00d4917c5ed39f2c37c9eb30cd46~wSbsL2p0M0129101291eucas1p1U;
        Wed, 18 May 2022 19:28:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220518192850eusmtrp1375c7b334a289cd0e986f8636d01d4cd~wSbsLJMu91238512385eusmtrp1Q;
        Wed, 18 May 2022 19:28:50 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-93-628548f49c9b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 44.45.09404.2F845826; Wed, 18
        May 2022 20:28:50 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220518192850eusmtip20a4cb69601b5afd4ab5fb994735000da~wSbrrYj490675106751eusmtip2t;
        Wed, 18 May 2022 19:28:50 +0000 (GMT)
Message-ID: <46253c48-81cb-0787-20ad-9133afdd9e21@samsung.com>
Date:   Wed, 18 May 2022 21:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
Content-Language: en-US
To:     bh1scw@gmail.com, tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220516173930.159535-1-bh1scw@gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7pfPFqTDJpWylmsvtvPZvH0x0km
        ixvLZ7BY7L2lbXF51xw2i4P3zzFb/Fp+lNGB3ePfiTVsHjtn3WX3uHy21GPTqk42j8+b5AJY
        o7hsUlJzMstSi/TtErgy9i95zVrwV7Ri/txFjA2MC4S6GDk5JARMJPYtf8PWxcjFISSwglHi
        RsN0VgjnC6PE/F3HmCGcz4wSi5f1scG0nN89nREisZxR4tfhLSwQzkdGif4FR5lAqngF7CT+
        r13ECmKzCKhK9PT3skPEBSVOznzCAmKLCiRJvHlzlRnEFhbwkljbfxmsl1lAXOLWk/lgtgjQ
        tseLXjFDxIskdmx4CXYFm4ChRNfbLjCbU8BcYt6fD2wQNfISzVtng50tIXCDQ+LpZ5BTQc52
        kZj+9B4zhC0s8er4FnYIW0bi9OQeoIM4gOx8ib8zjCHCFRLXXq+BKreWuHPuFxtICbOApsT6
        XfoQYUeJvmvdrBCdfBI33gpCXMAnMWnbdGaIMK9ERxs0pNUkZh1fB7fz4IVLzBMYlWYhhcks
        JL/PQvLLLIS9CxhZVjGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgQmn9P/jn/dwbji1Ue9
        Q4xMHIyHGCU4mJVEeBlzW5KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yZnbkgUEkhPLEnNTk0t
        SC2CyTJxcEo1MJXM0dFtT3m2Zc6nL0e19kpUWmWeDsmwW/fv1qK0S69etippv2Ncb1Dw5YGP
        sIpvb0KTZemCa0pMbUdP/PnzlX3nFabuJ5+7In0kt17efnuNzO77Jdqaznq7hdwE3Z+r+ug3
        1Fw9O/+M1iwj/wzztolBclMXq8pmnVW4rsd59u1lhinfS46I5sm+73lpuGzaw+tXD1/8JXts
        8sHdbkdTo6slOtlr5+5/Z5H9z+xOhNEFj81b2kPmh29ttlk6ydiJ9dbq5ywfjgvYHr8TnWao
        mXD21OW0CO0vQvdZ7xwQjXC4MD/r7P6Hokl/BE/Nn6gkuE3dVuijwUO+34sM/e/zSDk//2mq
        1qPksuqMuV/d9K9KLMUZiYZazEXFiQCX12nXrQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xe7qfPFqTDPr2GlqsvtvPZvH0x0km
        ixvLZ7BY7L2lbXF51xw2i4P3zzFb/Fp+lNGB3ePfiTVsHjtn3WX3uHy21GPTqk42j8+b5AJY
        o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy9i95
        zVrwV7Ri/txFjA2MC4S6GDk5JARMJM7vns7YxcjFISSwlFHiSct6RoiEjMTJaQ2sELawxJ9r
        XWwgtpDAe0aJ079FQGxeATuJ/2sXgdWwCKhK9PT3skPEBSVOznzC0sXIwSEqkCRx5DA/SFhY
        wEtibf9lJhCbWUBc4taT+WC2CNANjxe9YoaIF0lcOXecFWKVmcSGf7vBRrIJGEp0vYU4gVPA
        XGLenw9sEPVmEl1buxghbHmJ5q2zmScwCs1CcsUsJOtmIWmZhaRlASPLKkaR1NLi3PTcYiO9
        4sTc4tK8dL3k/NxNjMBo23bs55YdjCtffdQ7xMjEwXiIUYKDWUmElzG3JUmINyWxsiq1KD++
        qDQntfgQoykwKCYyS4km5wPjPa8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUI
        po+Jg1OqgUmS2/OVg6TrzGWrLn2+et904+mZ+tt9yz8Fsa3S4K2bWyb+K3vpi6JfU1Iclb5d
        s5DTFzJTulGbe3j/4g5Jt5W527Zwfos/nhSw8LRor6lRoqh6XtOCT3JCL61FklMmnKp4+VlH
        RV/4zv0TGWmdyefbo/bOuFK0+CT3rmxm52uJX1dIGV0W1/aYYzab762i6pR/1S8FypTV5e4r
        TdLw7E483Ll5SWrNQYVFH+ZIc185X/roquRvZif9a51qh4ovnnZ4ZNc6l+cLh1Tp7ln6y9tX
        3wjPblrWyVs8rT70vF3Pz6ddU8tm/KnYOvEc5+T587SX3yqpEG5ZEZTcINwdZNUtKbVvisPu
        hj/Ojn9q9iqxFGckGmoxFxUnAgCTradRPwMAAA==
X-CMS-MailID: 20220518192850eucas1p1458c00d4917c5ed39f2c37c9eb30cd46
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220518192850eucas1p1458c00d4917c5ed39f2c37c9eb30cd46
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220518192850eucas1p1458c00d4917c5ed39f2c37c9eb30cd46
References: <20220516173930.159535-1-bh1scw@gmail.com>
        <CGME20220518192850eucas1p1458c00d4917c5ed39f2c37c9eb30cd46@eucas1p1.samsung.com>
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 16.05.2022 19:39, bh1scw@gmail.com wrote:
> From: Fanjun Kong <bh1scw@gmail.com>
>
> spin_lock_irq/spin_unlock_irq contains preempt_disable/enable().
> Which can serve as RCU read-side critical region, so remove
> rcu_read_lock/unlock().
>
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

This patch landed in today's linux next-20220518 as commit 77c570a1ea85 
("blk-cgroup: Remove unnecessary rcu_read_lock/unlock()").

Unfortunately it triggers the following warning on ARM64 based Raspberry 
Pi 4B board:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at block/blk-cgroup.c:301 blkg_create+0x398/0x4e0
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc3+ #5080
Hardware name: Raspberry Pi 4 Model B (DT)
pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : blkg_create+0x398/0x4e0
...
Call trace:
  blkg_create+0x398/0x4e0
  blkcg_init_queue+0x74/0x204
  __alloc_disk_node+0xf8/0x1f0
  __blk_alloc_disk+0x38/0x140
  brd_alloc.part.0+0xf8/0x220
  brd_init+0xe8/0x164
  do_one_initcall+0x74/0x400
  kernel_init_freeable+0x2f4/0x37c
  kernel_init+0x28/0x130
  ret_from_fork+0x10/0x20
irq event stamp: 218372
hardirqs last  enabled at (218371): [<ffff80000914b99c>] 
_raw_spin_unlock_irqrestore+0x98/0x9c
hardirqs last disabled at (218372): [<ffff80000914bcbc>] 
_raw_spin_lock_irq+0xac/0xb0
softirqs last  enabled at (216732): [<ffff800008010470>] _stext+0x470/0x5e8
softirqs last disabled at (216723): [<ffff8000080a0ec4>] 
__irq_exit_rcu+0x180/0x1ac
---[ end trace 0000000000000000 ]---

If this is a false positive, then the check in the code needs to be 
adjusted.

> ---
>   block/blk-cgroup.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index a91f8ae18b49..7bdc16a36560 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1283,14 +1283,13 @@ int blkcg_init_queue(struct request_queue *q)
>   	preloaded = !radix_tree_preload(GFP_KERNEL);
>   
>   	/* Make sure the root blkg exists. */
> -	rcu_read_lock();
> +	/* spin_lock_irq can serve as RCU read-side critical section. */
>   	spin_lock_irq(&q->queue_lock);
>   	blkg = blkg_create(&blkcg_root, q, new_blkg);
>   	if (IS_ERR(blkg))
>   		goto err_unlock;
>   	q->root_blkg = blkg;
>   	spin_unlock_irq(&q->queue_lock);
> -	rcu_read_unlock();
>   
>   	if (preloaded)
>   		radix_tree_preload_end();
> @@ -1316,7 +1315,6 @@ int blkcg_init_queue(struct request_queue *q)
>   	return ret;
>   err_unlock:
>   	spin_unlock_irq(&q->queue_lock);
> -	rcu_read_unlock();
>   	if (preloaded)
>   		radix_tree_preload_end();
>   	return PTR_ERR(blkg);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

