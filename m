Return-Path: <cgroups+bounces-10420-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E9AB99718
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 12:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7ED7ABF12
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 10:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DAD2E03F2;
	Wed, 24 Sep 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lOat5XcY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ACF2DF3F2
	for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710228; cv=none; b=mHMVx6yzvoQpEQBXBAjsDnu1ZDTmW7HE06H+SvbVpIiVzB2AsUgcrnUfRcz16WgWzdSzocnvIf4eX06wVzYexadjBrrwfBnL3OMlj8vO7AqwoGS0VEqPJyvDPwmbu9zn8IxczrgijNfz7e+eVWW3aaNo3xHHSiowF6JS4Azae70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710228; c=relaxed/simple;
	bh=dRYlXXkB2uJmdz7xtD6gE7x4EFJTzXqpZbsUDTyd8c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H34jDNyeKDmqAxlCHMjZuWiN8JSetbnnodjR7C2U7zI6CFR9wBHMtDf4HfTJr4/8yhL42WWALTNYqZEp/gq//kBHtY4ZpwF8d+CJMYS1zRrzESYi3OrAk7YyU03g6LsPbFOdskAv/7f2xmTHCwxa3wRGq5q2XGHK4GZgQXT+oT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lOat5XcY; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b55517e74e3so3592618a12.2
        for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 03:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758710222; x=1759315022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz/QbJ4toKNKlZAJuEgAp+fvEFXAqbuxTuvTTDNq1Jo=;
        b=lOat5XcYibFTSQvkP0tr06i+EOUFBhTE0lzdpUWflDlzQox9LXotkg4wzzuIu2LH6+
         uMKggXIwsMQbjp+hcNGP2RySbqSNRsyhPwFNA1S85BLqNzxzl+R17Joov+PvtZZyT1VK
         x4Ki9+L1xQa+bHUPrinJ3IPplBQg7GGZwale4oWzsExuwOMvv9dQ4jVR1B7PWhYxtrbp
         6nuGmLMJTJURSLwHCGjR6SQOYcbTTRtMO0puvgiehNdbeYGJh+II6nb635wJgjM6Hput
         aUsL+ehlzPKuiKVUXTT5KCFAV6U7hiFjYTZK8WW5fcHa1vye+RsOpvJ5BYCITwAvF8KB
         etKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758710222; x=1759315022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mz/QbJ4toKNKlZAJuEgAp+fvEFXAqbuxTuvTTDNq1Jo=;
        b=MyC0XW1lM+VOHs1i668Nb87Pr1U4VFHvoNdTlhPACXyB18Z0Ygs4SNWEQ4i0vFCe2f
         jF4p3TtIfxoxriKz6R5purXEYjs3jXs5Pm4jV6gPZ9UDIbI4qfoKZ/czsrWAL+gN3V+J
         7afcQht0SR0S4QE0z/u9wq3vr79X1O4c5Q2NNQqkL1y/wJWhnDNA5eeyvdEnR3RZGgJp
         samFSK9Vu4FmMpyq8XQzWjjBOatLf6dSKcj/dXYxUogcc/ZvIaJD6YOWFaEXJg+z2uOe
         Odqr7G2KtTh1azETunkiAHQBGuGttdXmBIEuVZAr8rw35xGqImCEKq1mw/sBX7Oeg9O0
         CtUw==
X-Gm-Message-State: AOJu0YyK5Oa0DZa5BlIiFRKxwECP6g0fMHTJcZkokohAZgzulVJ9o2H0
	I5AtzJ2fmPxhWYNgO/FIUIDjpy+j7ki45FqMy3ce6l8O6wE+pOGMFLZQMU5xiodsePI=
X-Gm-Gg: ASbGncvCPgwoWLfDtilF6safv1HtFBpeqvzaNP6kDHZ9Ptrv8nsIs7z+Kq+YRRm66GB
	Um7DNGByo5M/aHr+lJ0fCwdiNEu2AQCsnblZjXciqK1iQDhhIonu4qe8R4jKS8BTv1nLKQBS2vH
	QqkJpRincEKKfwCl19WQUwdG+yNqSxcXVvBA4GCeu7ctKwF53KuEUSf11Riu0LibutnL3A+yM4U
	/id10Fhefyl/b4luSF2uYFAf1KM0bU5R4SPtGnDUBXQPTxwmDByfe1G/JFCBB4leaFBo2Rnb6GL
	9htrvBzaKnMpkgKyDck/XJN4Rb4W6pwdZtuEQ+zXfoYD7GDXUUYpntQwfUguTSgiqoeM8Wg35Av
	Q1SzZuCNqIaklC/JKZbSU4ldiQc1EcjXMXhoLimcCmYcRUS5VjenhwHSMuBfVh6ej7i8HkAoTlA
	==
X-Google-Smtp-Source: AGHT+IGcpm4z7o8NO6ljSagepQnFIpP0uGIzZYuk92q1VZe5grt2PvNSZ7U+YZG86LFac+Jm4g+HMQ==
X-Received: by 2002:a17:902:d484:b0:25c:d4b6:f119 with SMTP id d9443c01a7336-27cc09e3c46mr79698515ad.12.1758710222141;
        Wed, 24 Sep 2025 03:37:02 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053dbdsm188309915ad.9.2025.09.24.03.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:37:01 -0700 (PDT)
Message-ID: <b9fd9738-f4bd-4b34-88fd-7dfb7ed0c043@bytedance.com>
Date: Wed, 24 Sep 2025 18:36:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2 2/2] memcg: Don't trigger hung task
 warnings when memcg is releasing resources.
To: Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, lance.yang@linux.dev, mhiramat@kernel.org,
 yangyicong@hisilicon.com, will@kernel.org, dianders@chromium.org,
 mingo@kernel.org, lihuafei1@huawei.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, tj@kernel.org, brauner@kernel.org
References: <20250924034100.3701520-1-sunjunchao@bytedance.com>
 <20250924034100.3701520-3-sunjunchao@bytedance.com>
 <20250924063219.GR4067720@noisy.programming.kicks-ass.net>
 <37fd969e-3799-48d0-a8e0-1937e5a4ae38@bytedance.com>
 <20250924082823.GV3245006@noisy.programming.kicks-ass.net>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20250924082823.GV3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/25 4:28 PM, Peter Zijlstra wrote:

Hi,
> On Wed, Sep 24, 2025 at 03:50:41PM +0800, Julian Sun wrote:
>> On 9/24/25 2:32 PM, Peter Zijlstra wrote:
>>> On Wed, Sep 24, 2025 at 11:41:00AM +0800, Julian Sun wrote:
>>>> Hung task warning in mem_cgroup_css_free() is undesirable and
>>>> unnecessary since the behavior of waiting for a long time is
>>>> expected.
>>>>
>>>> Use touch_hung_task_detector() to eliminate the possible
>>>> hung task warning.
>>>>
>>>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
>>>
>>> Still hate this. It is not tied to progress. If progress really stalls,
>>> no warning will be given.
>>
>> Hi, peter
>>
>> Thanks for your review and comments.
>>
>> I did take a look at your solution provided yesterday, and get your point.
>> However AFAICS it can't resolve the unexpected warnings here. Because it
>> only works after we reach the finish_writeback_work(), and the key point
>> here is, it *already* takes a long time before we reach
>> finish_writeback_work(), and there is true progress before finish the
>> writeback work that hung task detector still can not know.
> 
> But wb_split_bdi_pages() should already split things into smaller chunks
> if there is low bandwidth, right? And we call finish_writeback_work()
> for each chunk.

AFAICS, wb_split_bdi_pages() will only be invoked in the sync scenarios, 
and not in the background writeback scenarios - which is exactly the 
case here.

And I noticed that there's something similar in background writeback, 
where writeback_chunk_size() will split all pages into several chunks, 
the min chunk size is 1024(MIN_WRITEBACK_PAGES) pages. The difference 
from wb_split_bdi_pages() is that we don't report progress after 
finishing the writeback of a chunk.
> 
> If a chunk is still taking too long, surely the solution is to use
> smaller chunks?

Yeah it still takes a long time, I checked the write_bandwidth and 
avg_write_bandwidth when warning was triggered:

	>>> wb.write_bandwidth
	(unsigned long)24
	>>> wb.avg_write_bandwidth
	(unsigned long)24
	>>> wb.write_bandwidth
	(unsigned long)13
	>>> wb.write_bandwidth
	(unsigned long)13

At this bandwidth, it will still takes a lot of seconds to write back 
MIN_WRITEBACK_PAGES pages.

So it might be a solution, but given the fact that the current minimum 
chunk size (1024) has been in place for over ten years, and that making 
it smaller would probably have a negative impact on performance. I'm 
afraid the filesystem maintainers will not accept this change.
If we don’t modify this part but can report progress after finishing the 
chunk writeback, it should probably eliminate most of the unexpected 
warnings.
> 
>> If we want to make the hung task detector to known the progress of writeback
>> work, we need to add some code within do_writepages(): after each finish of
>> a_ops->writepages(), we need to make detector to known there's progress.
>> Something like this:
>>
>> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>> index 3e248d1c3969..49572a83c47b 100644
>> --- a/mm/page-writeback.c
>> +++ b/mm/page-writeback.c
>> @@ -2635,6 +2635,10 @@ int do_writepages(struct address_space *mapping,
>> struct writeback_control *wbc)
>>                  else
>>                          /* deal with chardevs and other special files */
>>                          ret = 0;
>> +               /* Make hung task detector to known there's progress. */
>> +               if (force_wake)
>> +                       wake_up_all(waitq);
>> +
>>                  if (ret != -ENOMEM || wbc->sync_mode != WB_SYNC_ALL)
>>                          break;
>>
>> which has a big impact on current code - I don't want to introduce this.
> 
> You sure? It looks to me like the next level down is wb_writeback() and
> writeback_sb_inodes(), and those already have time based breaks in and
> still have access to wb_writeback_work::done, while do_writepages() no
> longer has that context.

Yeah, exactly. What I mean is report progress within the whole writeback 
work, either writeback_sb_inodes() or do_writepages() is ok.
> 
>> Yes, the behavior in this patch does have the possibility to paper cover the
>> real warnings, and what I want to argue is that the essence of this patch is
>> the same as the current touch_nmi_watchdog() and touch_softlockup_watchdog()
>> - these functions are used only in specific scenarios we known and only
>> affect a single event. And there seems no report that
>> touch_nmi/softlockup_watchdog() will paper cover the real warnings (do we?).
>>
>> Correct me if there's anything I'm missing or misunderstanding.
> 
> The thing with touch_nmi_watchdog() is that you need to keep doing it.
> The moment you stop calling touch_nmi_watchdog(), you will cause it to
> fire.
> 
> That is very much in line with the thing I proposed, and rather unlike
> your proposal that blanket kill reporting for the task, irrespective of
> how long it sits there waiting.
> 

Thanks for clarification. So how about the following solution?

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..e0698fd3f9ab 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -14,6 +14,7 @@
   *             Additions for address_space-based writeback
   */

+#include <linux/sched/sysctl.h>
  #include <linux/kernel.h>
  #include <linux/export.h>
  #include <linux/spinlock.h>
@@ -213,7 +214,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
  void wb_wait_for_completion(struct wb_completion *done)
  {
         atomic_dec(&done->cnt);         /* put down the initial count */
-       wait_event(*done->waitq, !atomic_read(&done->cnt));
+       wait_event(*done->waitq, (done->stamp = jiffies; 
!atomic_read(&done->cnt)));
  }

  #ifdef CONFIG_CGROUP_WRITEBACK
@@ -1975,6 +1976,11 @@ static long writeback_sb_inodes(struct 
super_block *sb,
                  */
                 __writeback_single_inode(inode, &wbc);

+               /* Report progress to make hung task detector know it. */
+               if (jiffies - work->done->stamp >
+                   HZ * sysctl_hung_task_timeout_secs / 2)
+                       wake_up_all(work->done->waitq);
+
                 wbc_detach_inode(&wbc);
                 work->nr_pages -= write_chunk - wbc.nr_to_write;
                 wrote = write_chunk - wbc.nr_to_write - wbc.pages_skipped;

Instead of waking up all waiting threads every half second, we only wake 
them up if the writeback work lasts for the value of 
sysctl_hung_task_timeout_secs / 2 seconds to reduce possible overhead.

Hi, Jan, Christian, how do you think about it?

Please correct me if there's anything I'm missing or misunderstanding.

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

