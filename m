Return-Path: <cgroups+bounces-15373-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNqBBFpn5mnBvwEAu9opvQ
	(envelope-from <cgroups+bounces-15373-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 19:50:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEDD432291
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 19:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E644B32B0007
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B8B33F8C2;
	Mon, 20 Apr 2026 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmkkjOD5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D7E3358B0
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700987; cv=pass; b=rMDtEVCQGWCT8u01h0AN3BA7g/yKti24gtRwRCeU7wJuEn9xY5BJ8+HL2z8/WgImH9NtChMy9MrFUS9PqG/UTdULnEMj1ezOgrx2SM5a0QTqZSQeIEfs8NgoORDygoATPW2NXoAkZ+X6Z3da0SjQNvyR1t9eaYldN5nqZ9rOgHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700987; c=relaxed/simple;
	bh=R9V9R4q8xvWULOX3gjvoRnt/IB++lyxSgzyFQ02/p8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6zgcJUw4/FnpavCjYNAT7J9mQJoo0CZXZUaKcaxZvhDqVqwfbbWZfpQUFKyVXseKZamMTToB+ovKoSEOGn0yr6iLAmUtuKThreuQo8XG/g8BEIY8UopPkrH9xwaf+bV382Dc302wxxhebWRnVb2FB6H+nw9LuCVSlte8bpkj58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmkkjOD5; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so46755655e9.2
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 09:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776700984; cv=none;
        d=google.com; s=arc-20240605;
        b=AkX+a6DEBEIZo5Eb7X3jXYokl251Spv75rs53aZnRJ70aw0yaR7Age8OFijday8Ngy
         MDv4DjTPIXV4bIWJYgU5R8AmML0tWycuddlEdjm/UlLaCP1CvhXJ46JIfhoWuo4pxJuD
         DT9o6um+e7AbmevTa1OY2XF9ljabTHNopIq+MgjRDVvKtgtotZn6SUlUA2ymCjfe6yLz
         5WI6/Zhi9CPy9z/ayHd7mCLv+71vWNccsyuRONNwjOovmObSrKsTRAQUn2KXquhEGgXc
         VxTx/kQQTXZzbYku4BujGXhLV5x25oN3CcOwr+wRBpMDu0whd2iljWWX+87iLqtDHdCR
         3uLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iBF/huw+jCdmavak8Kfcjpi9kTHcjyw4uzaIxzF9jcE=;
        fh=vepL5t0JIhyt3BBZgh7/LD2SObie15luew4Usd+cNws=;
        b=QJ9XehXoOmnhKSbUr+CnSXiWjdsRqOn5O7bgxiN2S5TM1KHwNCV2/9LYjA4iXE+3NW
         GFAjnemxZnbF/pw2sx8oVD7VMDfticjf6dHRLiWtPdOUB5ByDwdr3Nqw5G0VtqLlOEZM
         rcTlA68HoLvGFibmW3Y30Grf7gG9FMFVqMKG/YJUxBDbKmM6Q8iK3Y+w4wbuzWP1ZA2V
         oL3/UTFhmR2RLAWAvX4I4c8/6yV2sbj9uxrllWZaiYOGikqHEcMlWUeLxUOCm0+ucYt4
         GzVAN4FnptlnJjIIx7dWcgdLPk6NOhr47IKfLWMFXS1wIXYC22u57XTvo0N+fLjlMcU6
         avUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776700984; x=1777305784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBF/huw+jCdmavak8Kfcjpi9kTHcjyw4uzaIxzF9jcE=;
        b=NmkkjOD5u/+xKdbPi3ue948LOpoVNlpcP93rwGZQRjN4eC2c4+BbPMvh/gJk+u0fNy
         nHkU5uJu7/oSzvXPTJ+9wr81WiYxhhVo7xQDskFeZO78P5xDddoSoYOfOQ77obBpmrCf
         rhKjqjus5yuPp3zE6YheSV7Fw4ZYnQ5lJh+phdHn6TZmtqDZZEIRTrTzPaiv3X7HDeyb
         ovt1juVx8YkxiJXIf2QtY1Q6nn/4Yf3rrkHmQNz1YhHf6ycWNjO/nqFQWZoAVVSvefJ4
         ZAOQ0LlxoILJa8/eTVekAXqxIhjV30BD0FdUwSUzcTyE/o1qKWQ9nXQWtb7Mb8g5v15v
         sVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776700984; x=1777305784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBF/huw+jCdmavak8Kfcjpi9kTHcjyw4uzaIxzF9jcE=;
        b=Fw1CaIXkBa0/3xvsrwIblOqzdp2PNl90I5lDapf0OShAtJ+k/u8f242A7A+oDhfuei
         6YzlL22/9i9Kczx4+fLP6V69QJ22jdNwa0/3dYJOcwSt24+JVO5zmaeCwA76Eu7sbRE8
         IsKB03imsiDqacZvVPCE58XcxfdMH3s1EGwpgMDEtoaAUdaZaxi0W5MdxsEGk0yTq/ft
         +ktb3x0kXOPNX47nxaAqRxA5wG0M/jBj8PsE4J5sDu8RCPXMgjKKI2s5CMdDd1Cz5QFJ
         xAScCvTZNuFpfOxuEm80RquT88StXbx0Ex+2g9/tSJ7WFP+I/NRBuzlEmoKv3KGNIcnr
         UYLg==
X-Forwarded-Encrypted: i=1; AFNElJ+VeZzja5GNl0ry2oeJJnXMRk1FpHgf0iZXqRQp6dPdmtw+2wQUesryXCfC66CgU9xVdmelbV+3@vger.kernel.org
X-Gm-Message-State: AOJu0YxPgBWA3THgiZMZj+lHt5uEMhgXLgQtR0FCA901vStpq6K91wol
	3ZjeKLbRyHPT/JLUXKGArJC3zId6ZrPYKM9DYDgUrv2TnjIW0tNYkKyoUgGntmmNofIkoLfRIKW
	q9HSptqRbJifSi+YFmrrFizLFfvG9f28=
X-Gm-Gg: AeBDietwOGSL0Vs3GfO2ZkpYjd6S4LrMR3QNFFFoEcCsmybqGmM48RhcayuIxTkcs8l
	lqnHpkIrPBW3p0APEvqCi3YLIGDicAjzZKi+DakdM4e/Z+nxmnIqJbzs7SQM6MgiPIwL2FCc2SK
	5X7khf4oj/9MNMU8KBQkTpn9tmKjmlsKH5+Gu1aKxgbhxAbLRUJrJgqh8BMGeJ4tCu0E9UbxG4Y
	fUrf8kkhcss2sU1+3spaidoDZDITkVHXURFN8QHjxA6o1QQS8wxZVc4YRmXLPboPIbM2uF09Dq/
	DyAvGrMcAR8CVlpreH0EnpNBnx1Z73tN3v5bGx7tgsiUcz6Hou0UVxsRuKu8tILRIg==
X-Received: by 2002:a05:600d:8449:b0:488:a894:b27a with SMTP id
 5b1f17b1804b1-488fb74a8c2mr175647735e9.8.1776700983794; Mon, 20 Apr 2026
 09:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
In-Reply-To: <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 20 Apr 2026 09:02:52 -0700
X-Gm-Features: AQROBzDxid6PXLYOtsvRL4lA7x1zRB3nMTMN0giu6Su7fE6kLvWGH4GcqL7x9i4
Message-ID: <CAKEwX=M4nWeAw1-geCwABuv-0okz3-x9SwNswL-1Ks9KEAS6Mw@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15373-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[53];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CEDD432291
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 3:09=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, Mar 21, 2026 at 3:29=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> > This patch series is based on 6.19. There are a couple more
> > swap-related changes in mainline that I would need to coordinate
> > with, but I still want to send this out as an update for the
> > regressions reported by Kairui Song in [15]. It's probably easier
> > to just build this thing rather than dig through that series of
> > emails to get the fix patch :)
> >
> > Changelog:
> > * v4 -> v5:
> >     * Fix a deadlock in memcg1_swapout (reported by syzbot [16]).
> >     * Replace VM_WARN_ON(!spin_is_locked()) with lockdep_assert_held(),
> >       and use guard(rcu) in vswap_cpu_dead
> >       (reported by Peter Zijlstra [17]).
> > * v3 -> v4:
> >     * Fix poor swap free batching behavior to alleviate a regression
> >       (reported by Kairui Song).
>
> I tested the v5 (including the batched-free hotfix) and am still
> seeing significant regressions in both sequential and concurrent swap
> workloads
>
> Thanks for the update as I can see It's a lot of thoughtful work.
> Actually I did run some tests already with your previously posted
> hotfix based on v3. I didn't update the result because very
> unfortunately, I still see a major performance regression even with a
> very simple setup.
>
> BTW there seems a simpler way to reproduce that, just use memhog:
> sudo mkswap /dev/pmem0; sudo swapon /dev/pmem0; time memhog 48G; sudo swa=
poff -a
>
> Before:
> (I'm using fish shell on that test machine so this is fish time format):
> ________________________________________________________
> Executed in   20.80 secs    fish           external
>    usr time    5.14 secs    0.00 millis    5.14 secs
>    sys time   15.65 secs    1.17 millis   15.65 secs
> ________________________________________________________
> Executed in   21.69 secs    fish           external
>    usr time    5.31 secs  725.00 micros    5.31 secs
>    sys time   16.36 secs  579.00 micros   16.36 secs
> ________________________________________________________
> Executed in   21.86 secs    fish           external
>    usr time    5.39 secs    1.02 millis    5.39 secs
>    sys time   16.46 secs    0.27 millis   16.46 secs
>
> After:
> ________________________________________________________
> Executed in   30.77 secs    fish           external
>    usr time    5.16 secs  767.00 micros    5.16 secs
>    sys time   25.59 secs  580.00 micros   25.59 secs
> ________________________________________________________
> Executed in   37.47 secs    fish           external
>    usr time    5.48 secs    0.00 micros    5.48 secs
>    sys time   31.98 secs  674.00 micros   31.98 secs
> ________________________________________________________
> Executed in   31.34 secs    fish           external
>    usr time    5.22 secs    0.00 millis    5.22 secs
>    sys time   26.09 secs    1.30 millis   26.09 secs
>
> It's obviously a lot slower.
>
> pmem may seem rare but SSDs are good at sequential, and memhog uses
> the same filled page and backend like ZRAM has extremely low overhead
> for same filled pages. Results with ZRAM are very similar, and many
> production workloads have massive amounts of samefill memory.
>
> For example on the Android phone I'm using right now at this moment:
> # cat /sys/block/zram0/mm_stat
> 4283899904 1317373036 1370259456        0 1475977216   116457  1991851
>    87273  1793760
> ~450M of samefill page in ZRAM, we may see more on some server
> workload. And I'm seeing similar memhog results with ZRAM, pmem is
> just easier to setup and less noisy. also simulates high speed
> storage.
>
> I also ran the previous usemem matrix, which seems better than V3 but
> still pretty bad:
> Test: usemem --init-time -O -n 1 56G, 16G mem, 48G swap, avgs of 8 run.
> Before:
> Throughput (Sum): 528.98 MB/s Throughput (Mean): 526.113333 MB/s Free
> Latency: 3037932.888889
> After:
> Throughput (Sum): 453.74 MB/s Throughput (Mean): 454.875000 MB/s Free
> Latency: 5001144.500000 (~10%, 64% slower)
>
> I'm not sure why our results differ so much =E2=80=94 perhaps different L=
RU
> settings, memory pressure ratios, or THP/mTHP configs? Here's my exact
> config in the attachment. Also includes the full log and info, with
> all debug options disabled for close to production. I ran it 8 times
> and just attached the first result log, it's all similar anyway, my
> test framework reboot the machine after each test run to reduce any
> potential noise.
>
> And the above tests are only about sequential performance, concurrent
> ones seem worse:
> Test: usemem --init-time -O -R -n 32 622M, 16G mem, 48G swap, avgs of 8 r=
un.
> Before:
> Throughput (Sum): 5467.51 MB/s Throughput (Mean): 170.04 MB/s Free
> Latency: 28648.65
> After:
> Throughput (Sum): 4914.86 MB/s Throughput (Mean): 152.74 MB/s Free
> Latency: 67789.81 (~10%, 230% slower)

For this test case, I took my 16G (a bit less than that technically)
52 cores host, using zram as the backend and MGLRU, for a spin.

Keeping the same parameters as your usemem command, unfortunately, led
to massive thrashing (even with baseline kernel) - unfortunately zram
still used physical memory so the overcommit level is too large
(especially with random access pattern, i.e the -R flag).

I then tried reducing the 622M part to 480M, but the problem with that
is VSS5 did not show any regression - probably because the
overcommitting is too low, or not enough concurrency. I had to push
the concurrency up to 52 workers, allocating 300M each (which is
slightly more memory allocated overall than the 480 x 32 case), to
finally show the regression you reported. Variance was very big with 8
runs though (what I normally use for usemem these days), so I had to
do 20 runs per kernel - fortunately these runs are fast:


Metric      baseline       vss_v5         new_opt_v2     cc_v2
real (s)    15.0 +/- 0.8   18.3 +/- 1.8   15.1 +/- 1.0   14.7 +/- 1.0
sys (s)     396.4 +/- 31.1 511.9 +/- 60.3 404.1 +/- 34.5 392.4 +/- 39.9
tput (KB/s) 28188 +/- 6996 23287 +/- 6629 27999 +/- 6623 28744 +/- 7015
free (ms)   101.1 +/- 52.4 91.4 +/- 41.5  93.1 +/- 43.8  97.6 +/- 49.5
% real      n/a            +22.4%         +0.7%          -1.7%
% sys       n/a            +29.1%         +1.9%          -1.0%
% tput      n/a            -17.4%         -0.7%          +2.0%
% free      n/a            -9.6%          -7.9%          -3.5%


(I realized I mangled the output last time of the "memory reclaim
metrics table" table due to auto line break. Let's hope this is
better).

Strangely, no free regression. Hmmm.

But real, sys, and throughput regression are real. The optimizations
do close the gap to within noise level here too.

