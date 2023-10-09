Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7CA7BD2F5
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 08:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345128AbjJIGAf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 02:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbjJIGAe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 02:00:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D308EB3;
        Sun,  8 Oct 2023 23:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696831232; x=1728367232;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=hpaPgeIMG2zlYHoqAZdtDRddF3V5fjkDFzWnHtt29sc=;
  b=BBBe7DK8ShUUCP3rkz48w+U9IH1nqK1P8rki0JMXw7Uchj0/VUneXUrj
   grUXGjO0gmoB8hr/pa36pHsrKpXXAPLItPqio8t+jR7lUQFGIMSVL1GQ1
   SJXzS9Jn6gW1BIICfGn9NRgS0kUXbQqJErOm9vfVsVVNGf02Y11S9DFfE
   DSPmKRHblQ8xP+dUeKOJA1S2M4fuF33r/iu7r3YNrk8ib1fEvwnl3DCU/
   cDj59hdtRhW72s2bJN84aIpSQnLs/kVPnZyOH0Y5sb+kCLipOHQytTASy
   SPsUjjum0laTKw8Uj6ltX/gLdIHjeUerhHeS3sgcBjquaxy208qyB4MUP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="383952888"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="383952888"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 23:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="1000069872"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="1000069872"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 23:00:25 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Jianlin Lv <iecedge@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, yosryahmed@google.com,
        willy@infradead.org, linmiaohe@huawei.com,
        wangkefeng.wang@huawei.com, laoar.shao@gmail.com,
        yuzhao@google.com, wuyun.abel@bytedance.com, david@redhat.com,
        peterx@redhat.com, vishal.moola@gmail.com, hughd@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jianlv@ebay.com
Subject: Re: [PATCH] memcg: add interface to force disable swap
References: <20231007130905.78554-1-jianlv@ebay.com>
        <87mswtkj8x.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAFA-uR9ymPTktMbi96cb+smjQHB4Y=8SQfAqmsqTbniGbkGTLA@mail.gmail.com>
        <87il7hjzdp.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAFA-uR9n-rKw4k26Bhm=P16jOMtAncRsno7o=yYJ1kTxmB_mRw@mail.gmail.com>
Date:   Mon, 09 Oct 2023 13:58:10 +0800
In-Reply-To: <CAFA-uR9n-rKw4k26Bhm=P16jOMtAncRsno7o=yYJ1kTxmB_mRw@mail.gmail.com>
        (Jianlin Lv's message of "Sun, 8 Oct 2023 17:34:44 +0800")
Message-ID: <87edi4jq19.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Jianlin Lv <iecedge@gmail.com> writes:

> On Sun, Oct 8, 2023 at 4:26=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Jianlin Lv <iecedge@gmail.com> writes:
>>
>> > On Sun, Oct 8, 2023 at 9:17=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
>> >>
>> >> Jianlin Lv <iecedge@gmail.com> writes:
>> >>
>> >> > From: Jianlin Lv <iecedge@gmail.com>
>> >> >
>> >> > Global reclaim will swap even if swappiness is set to 0.
>> >>
>> >> Why?  Can you elaborate the situation?
>> >
>> > We reproduced the issue of pages being swapped out even when swappines=
s is
>> > set to 0 in the production environment through the following test prog=
ram.
>> > Not sure whether this program can reproduce the issue in any environme=
nt.
>> >
>> > From the implementation of the get_scan_count code, it can be seen tha=
t,
>> > based on the current runtime situation, memory reclamation will choose=
 a
>> > scanning method (SCAN_ANON/SCAN_FILE/SCAN_FRACT) to determine how
>> > aggressively the anon and file LRU are scanned. However, this introduc=
es
>> > uncertainty.
>> >
>> > For the JVM issue at hand, we expect deterministic SCAN_FILE scan to a=
void
>> > swapping out anon pages.
>>
>> Why doesn't memory.swap.max work?
>
> The main reason is that deployed nodes  are kept on cgroups v1.

Check the code again.  IIUC, for swappiness =3D=3D 0, anonymous pages will
only be reclaimed if sc->file_is_tiny is true.  If we don't swap in that
situation, OOM may be triggerred.  I don't think that it's a good idea
to do that.  Or I miss something?

--
Best Regards,
Huang, Ying
