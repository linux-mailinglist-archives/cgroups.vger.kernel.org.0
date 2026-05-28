Return-Path: <cgroups+bounces-16395-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CsIgBxCKGGrCkwgAu9opvQ
	(envelope-from <cgroups+bounces-16395-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 20:31:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0AB5F64F4
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 20:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0E903047BDB
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 18:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6D83F888D;
	Thu, 28 May 2026 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="YSd5axA1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47504028EE
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992752; cv=pass; b=aV0I9q1ztXCEgP+4Wum5c30DzrPuzOltKujyWn8+xHE+aAdD820QiOh7ULLlCPFoJVu93YVUtixWVdt2ThHRxdOgflI//gAAwlpYn8uI4qm2FkBRRgHu2ppwOUZEfdZP9L780UmzncSOuzuWJpbMXkzxfkPuIpc8Zu89Y6+v7hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992752; c=relaxed/simple;
	bh=uX/zs0fhuoRwV5n41yMRkxgZNGPd2iu1ix3Kkaxjq/w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=F3+pLpWUbR+1bljpk4yEiTDd9YqJhbb2803JGbz+yr5mgXEg8QkY174gOX5N4cbQ7mLnv7/EJhsOydKm/YKIpdfVhCycVqHQawNlswYzLotIa8VuvB817BPvoQIXNn3R6t6E6KXotZ6Co9CQuDHI65SLm07eanMxijytvZjrXdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=YSd5axA1; arc=pass smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7c307937816so124206237b3.0
        for <cgroups@vger.kernel.org>; Thu, 28 May 2026 11:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779992750; cv=none;
        d=google.com; s=arc-20240605;
        b=YINX8KbZH99oZHv8YXMyiRULs3+RqG9vi+YeJgna6dhLkuV4nybHBZdF6ErQraHXAC
         tSN1U45Z51X5e8KKj/sv8FHd/ckmp6N2KvCbHip9Gk17Q6L+C4vKCCW51rY2W1zCF/hF
         MomSDYuuL0rpkPSIaIJ7FV3Rt7R+VVoAlitAusViq2JCD6vvVufz2oLGUYv0YY6N994n
         +77c+ToHSm5Y0QmGEYY9peb0LY1iUJb7vjmZPGiLh8GgOMhXVNSqEqg4VQtvDGy5fUqy
         RHojaKn95zkNJkXDRhcP+67n6GfT88SdboQJjVpbGKL13RkJCQdsdPCzsh2Cz8EiNWeO
         AtVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=6+tSeTpyx3CitJbaFuLZe+yBD6WSRrsGEXL8VTDfKLQ=;
        fh=/wxVrpwXoyFPvktEJZlV10KvnzNkrRs2E/fbcZx6dzU=;
        b=iaaw9Q+nP3EOKLLxLD60gmQcmy6ZLui9jsSuL9SP4Q9OU8pxZArKnJHX5iPtjYukJ0
         tV+UQv8XL+XxROjIqmciJncQzqV+jX41lDNRFZ6B9zbHxHgHJ3J5wON0v8t74IjbJPdE
         Y5OIDLw9+k6iSXbP/10g7nNo+tk28MfApl9C7soytJRLlQmqJBTEjGk/+wlum23x5VT+
         1EquZDzaG5iYpxUrkvTZYG4LGhYq97C5NQUJHn39kS2FMSglBCHpuch86mnb451UNACR
         oB7hcZPoBT6Ey5HU5n+dfT0lquZE5MZsabvaAPpSRB+OB9WBggzsXkr/431ckVJ+Y4Ic
         8NoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1779992750; x=1780597550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6+tSeTpyx3CitJbaFuLZe+yBD6WSRrsGEXL8VTDfKLQ=;
        b=YSd5axA1XiyicNAvV9tHZdtxCHPAlnoyLrSre9dLb4BeCHZteQm4vdIbQpW2ZR6p/s
         pzzbGDP07OtW149Agx5S2y1FztgAXC/23BCkSU6NJle52VSCuhE/L7QcFMtL3qCg6E9i
         rFMUKuvrDmh+2e60B6mR1gYJ1FHmsBrwqXUZcIte989KWRVGmFmr2JJMYP5Tfj8JHux3
         SchyALrGQPbdV54I2lUmhp88mvOmZesVyuFm9Nn2trWLDr+EXerc7tBR1iSC9xqiO3fT
         Urn17Ow/5PcOOq05Ak+22PbZV2To94aZprK5UiW3IX1fuzUIZRuIG9U+sX7ee0eFeluK
         IW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992750; x=1780597550;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+tSeTpyx3CitJbaFuLZe+yBD6WSRrsGEXL8VTDfKLQ=;
        b=OZ6cOzbkmYZ1HPTgHcYGGw5ezoyvl4MXVpEwPm/YJHXiD7TMGw+KN3VJpTAS+0dK3E
         fEaWUAzqqcjDKTNav/q+aspbIyAm32VqXdOwsEtsXpUzxkMzaubPUFremP50MYZh9KgR
         uiQFXHLSI8cFiSydrGwE66MgHaqV9NSYSOUZx9VqN+sTSp9wpsZS27YTnNjVrfqZ1jrW
         CxvEM3/bh5+AXVFVB2NVBvFyXSV1TV38kggYYIohCYJ8zRVhOX/6hTGUdPsjbUglHGuG
         0O2cxOqW2wUE+bXxhwSdZSz26jQ1sci9Aw1pVgzBOZVnrddslkEcS2txSzVq4DEg/Tz3
         8TPg==
X-Forwarded-Encrypted: i=1; AFNElJ8GtgmLnfrHXOhN86WXWIH13AmmceZ+ExrDT27YB+oBHuUk5hO+hadCx+3ijfSmRM255KzG1ALc@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9gkk15eb4oTorULWfg1kfs1sPlYyTiXvVFUF3pOS1s8Ugnbo
	pimLKjxlNiFKEcum4hWMm3R16S4DW1CQeGOZ3efT07aOESU4GXS015gjE2mQmHGpPkrD89oJces
	OOtJg05OZ7PM/gx+ynWJjkJeeGmfPutalAZ7f8co6
X-Gm-Gg: Acq92OFvPbVhfdhNmUorggrGkzLS+Ho4Nk5QUZEjcXao06B8T3LUIqX7bzzrHQv9B3W
	1vydwMIeaf8ob2/smVbZLsUHPiyUSW9VDAiBfIMl9MsaIuAtevXzIsbLQUgQi3S/hCzuOCH9E6K
	fpbZEHxUbp9DDgPEzX/cGnMw9oiIdkcvtV+AZHecJlocU3VBjStlpWPQHpMiEkRm7p/4+zgbsWa
	WUM6ypw0640GU/UoF+ED32If97g8giC1wxQUbLAQA44PrFOeNJj5Z2cLYFyI6qk4nQ0zwJvIfUD
	mPl0k1OktrojNJT8AQ==
X-Received: by 2002:a05:690c:4d42:b0:7bd:7e01:8d6c with SMTP id
 00721157ae682-7ddc5519b55mr3052497b3.50.1779992748401; Thu, 28 May 2026
 11:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Thu, 28 May 2026 11:25:36 -0700
X-Gm-Features: AVHnY4L4xx-nCT3mPulo2KgfwwydXmuW09L-mRPZvEPP12bQX_2VIHsqSp_UQZM
Message-ID: <CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com>
Subject: [BUG] lib/bitmap: divide error in bitmap_fold() when sz argument is 0
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <yury.norov@gmail.com>, Waiman Long <longman@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000079ab2e0652e4dbd5"
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[berkeley.edu,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[berkeley.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16395-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,rasmusvillemoes.dk,vger.kernel.org,kvack.org];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[farhad.alemi@berkeley.edu,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[berkeley.edu:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,berkeley.edu:dkim]
X-Rspamd-Queue-Id: 5F0AB5F64F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000079ab2e0652e4dbd5
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting a divide-by-zero crash in bitmap_fold() found by syzkaller.

Summary:
bitmap_fold() at lib/bitmap.c divides by its `sz` parameter without
guarding sz != 0:

  void bitmap_fold(unsigned long *dst, const unsigned long *orig,
                   unsigned int sz, unsigned int nbits)
  {
          ...
          for_each_set_bit(oldbit, orig, nbits)
                  set_bit(oldbit % sz, dst);
  }

The call chain in the observed crash is:

  mpol_relative_nodemask()   mm/mempolicy.c
    nodes_fold(tmp, *orig, nodes_weight(*rel))
  __nodes_fold()              include/linux/nodemask.h
    bitmap_fold(dstp->bits, origp->bits, sz, nbits)
  bitmap_fold()               lib/bitmap.c

When `nodes_weight(*rel)` is 0 (i.e. the relative-nodes mask is empty),
the `sz` argument passed to bitmap_fold() is 0, and the
`oldbit % sz` expression executes a divl by zero.

Observed on:
- Linux v6.18.32-dirty (where the bug was originally found), x86_64,
  QEMU Q35
- KASAN enabled; panic_on_warn set
- The only local dirty file in my tree is drivers/tty/serial/serial_core.c,
  containing a local ttyS0 console guard for the fuzzing harness. It is
  unrelated to lib/bitmap, mm/mempolicy, or kernel/cgroup/cpuset.
- The crash fires in a cpu-hotplug kernel thread (Comm: cpuhp/1, PID 21)
  reached via sched_cpu_deactivate -> cpuset_handle_hotplug ->
  cpuset_update_tasks_nodemask -> mpol_rebind_mm -> mpol_rebind_policy
  -> mpol_rebind_nodemask -> mpol_relative_nodemask -> __nodes_fold ->
  bitmap_fold.
- Source inspection of linus/master at commit e8c2f9fdadee
  (v7.1-rc4-754-ge8c2f9fdadee) shows the buggy structure is unchanged:
  bitmap_fold() at lib/bitmap.c:718 still computes `oldbit % sz` with
  no sz != 0 guard; __nodes_fold() at include/linux/nodemask.h:365
  still forwards its sz argument; mpol_relative_nodemask() at
  mm/mempolicy.c:370 still calls nodes_fold(tmp, *orig,
  nodes_weight(*rel)). I have not re-run a reproducer against
  e8c2f9fdadee as no standalone reproducer is available yet.

Impact:
A divide-by-zero in a cpu-hotplug kernel thread context kills the
kernel:

  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
  CPU: 1 UID: 0 PID: 21 Comm: cpuhp/1 Not tainted 6.18.32-dirty #1 PREEMPT(full)
  RIP: 0010:bitmap_fold+0x5e/0xb0 lib/bitmap.c:713

The crash report's code disassembly pins the trapping instruction to
`divl 0x4(%rsp)` (bytes `f7 74 24 04`) with %edx pre-zeroed by the
preceding `xor %edx,%edx` -- i.e. a 32-bit unsigned divide by the
on-stack `sz` value.

Relevant stack:

  bitmap_fold+0x5e/0xb0 lib/bitmap.c:713
  __nodes_fold include/linux/nodemask.h:369 [inline]
  mpol_relative_nodemask mm/mempolicy.c:372 [inline]
  mpol_rebind_nodemask+0x1e9/0x2d0 mm/mempolicy.c:508
  mpol_rebind_policy mm/mempolicy.c:542 [inline]
  mpol_rebind_mm+0x3ab/0x680 mm/mempolicy.c:569
  cpuset_update_tasks_nodemask+0x22e/0x340 kernel/cgroup/cpuset.c:2777
  hotplug_update_tasks kernel/cgroup/cpuset.c:3882 [inline]
  cpuset_hotplug_update_tasks kernel/cgroup/cpuset.c:3985 [inline]
  cpuset_handle_hotplug+0xe52/0x1200 kernel/cgroup/cpuset.c:4089
  cpuset_cpu_inactive kernel/sched/core.c:8377 [inline]
  sched_cpu_deactivate+0x497/0x600 kernel/sched/core.c:8493
  cpuhp_invoke_callback+0x44a/0x860 kernel/cpu.c:195
  cpuhp_thread_fun+0x40f/0x870 kernel/cpu.c:1105
  smpboot_thread_fn+0x546/0xa50 kernel/smpboot.c:160
  kthread+0x73e/0x8c0 kernel/kthread.c:432

Expected behavior:
Either bitmap_fold() should guard against sz == 0 (return early or
WARN+return), or the callers in the nodes_fold / mpol_relative_nodemask
chain should not pass a zero `sz` (e.g. short-circuit the rebind when
the relative nodemask is empty).

Reproducer:
A standalone .syz or C reproducer was not produced for this seed; the
crash fired during broader cpu/cgroup/mempolicy fuzzing. The console
report is attached as crash-report.txt.

Novelty check:
I searched the syzbot dashboard's upstream open, fixed, stable, and
invalid (per-subsystem mempolicy/mm/cgroups) namespaces, the Android
dashboard, and the marc.info linux-mm and linux-kernel archives, for
"bitmap_fold", "mpol_rebind_nodemask" + "divide error", "__nodes_fold"
+ "BUG"/"Oops", and "cpuset_handle_hotplug" + "BUG". I did not find an
exact match. The recent Jinjiang Tu series (mainline commit
3d702678f57e, "mm/mempolicy: fix mpol_rebind_nodemask() for
MPOL_F_NUMA_BALANCING") is a sibling fix in the same function but
addresses wrong-rebind logic under NUMA balancing, not the
divide-by-zero in bitmap_fold().

I appreciate your time and consideration, and I'm grateful for your
work on this subsystem. I'd be glad to test any candidate patches.

Regards,

--00000000000079ab2e0652e4dbd5
Content-Type: text/plain; charset="US-ASCII"; name="crash-report.txt"
Content-Disposition: attachment; filename="crash-report.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mpptowhs0>
X-Attachment-Id: f_mpptowhs0

T29wczogZGl2aWRlIGVycm9yOiAwMDAwIFsjMV0gU01QIEtBU0FOIE5PUFRJCkNQVTogMSBVSUQ6
IDAgUElEOiAyMSBDb21tOiBjcHVocC8xIE5vdCB0YWludGVkIDYuMTguMzItZGlydHkgIzEgUFJF
RU1QVChmdWxsKSAKSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwg
MjAwOSksIEJJT1MgMS4xNi4zLWRlYmlhbi0xLjE2LjMtMiAwNC8wMS8yMDE0ClJJUDogMDAxMDpi
aXRtYXBfZm9sZCsweDVlLzB4YjAgbGliL2JpdG1hcC5jOjcxMwpDb2RlOiAzMSBmNiBlOCBhNSA0
ZSAyMCBmZSA0MSA4OSBkYyA0NCA4OSBlYSA0YyA4OSBmNyA0YyA4OSBlNiBlOCA4NCBmMiAwMSAw
MCA0OSA4OSBjNSA0NCAzOSBlYiA3NiAyZCBlOCBmNyBmYyBiOSBmZCA0NCA4OSBlOCAzMSBkMiA8
Zjc+IDc0IDI0IDA0IDg5IGQ1IDg5IGQwIGMxIGU4IDA2IDQ5IDhkIDNjIGM3IGJlIDA4IDAwIDAw
IDAwIGU4IDM5ClJTUDogMDAxODpmZmZmYzkwMDAwMTZmNTIwIEVGTEFHUzogMDAwMTAyNDYKUkFY
OiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDAwMDAwMDA0MCBSQ1g6IGZmZmY4ODgxMDI2
YTAwMDAKUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDAwMDAwMDA0MCBSREk6IGZm
ZmY4ODgxMjZmNmYyMTgKUkJQOiBmZmZmYzkwMDAwMTZmNjMwIFIwODogZmZmZmM5MDAwMDE2ZjVh
NyBSMDk6IDAwMDAwMDAwMDAwMDAwMDAKUjEwOiBmZmZmYzkwMDAwMTZmNWEwIFIxMTogZmZmZmY1
MjAwMDAyZGViNSBSMTI6IDAwMDAwMDAwMDAwMDAwNDAKUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIx
NDogZmZmZjg4ODEyNmY2ZjIxOCBSMTU6IGZmZmZjOTAwMDAxNmY1YTAKRlM6ICAwMDAwMDAwMDAw
MDAwMDAwKDAwMDApIEdTOmZmZmY4ODgyYWJjYzQwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAw
MDAwMApDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCkNS
MjogMDAwMDdmY2Q4YzljNmZlOCBDUjM6IDAwMDAwMDAxOTI3NTgwMDAgQ1I0OiAwMDAwMDAwMDAw
NzUwZWYwClBLUlU6IDU1NTU1NTU0CkNhbGwgVHJhY2U6CiA8VEFTSz4KIF9fbm9kZXNfZm9sZCBp
bmNsdWRlL2xpbnV4L25vZGVtYXNrLmg6MzY5IFtpbmxpbmVdCiBtcG9sX3JlbGF0aXZlX25vZGVt
YXNrIG1tL21lbXBvbGljeS5jOjM3MiBbaW5saW5lXQogbXBvbF9yZWJpbmRfbm9kZW1hc2srMHgx
ZTkvMHgyZDAgbW0vbWVtcG9saWN5LmM6NTA4CiBtcG9sX3JlYmluZF9wb2xpY3kgbW0vbWVtcG9s
aWN5LmM6NTQyIFtpbmxpbmVdCiBtcG9sX3JlYmluZF9tbSsweDNhYi8weDY4MCBtbS9tZW1wb2xp
Y3kuYzo1NjkKIGNwdXNldF91cGRhdGVfdGFza3Nfbm9kZW1hc2srMHgyMmUvMHgzNDAga2VybmVs
L2Nncm91cC9jcHVzZXQuYzoyNzc3CiBob3RwbHVnX3VwZGF0ZV90YXNrcyBrZXJuZWwvY2dyb3Vw
L2NwdXNldC5jOjM4ODIgW2lubGluZV0KIGNwdXNldF9ob3RwbHVnX3VwZGF0ZV90YXNrcyBrZXJu
ZWwvY2dyb3VwL2NwdXNldC5jOjM5ODUgW2lubGluZV0KIGNwdXNldF9oYW5kbGVfaG90cGx1Zysw
eGU1Mi8weDEyMDAga2VybmVsL2Nncm91cC9jcHVzZXQuYzo0MDg5CiBjcHVzZXRfY3B1X2luYWN0
aXZlIGtlcm5lbC9zY2hlZC9jb3JlLmM6ODM3NyBbaW5saW5lXQogc2NoZWRfY3B1X2RlYWN0aXZh
dGUrMHg0OTcvMHg2MDAga2VybmVsL3NjaGVkL2NvcmUuYzo4NDkzCiBjcHVocF9pbnZva2VfY2Fs
bGJhY2srMHg0NGEvMHg4NjAga2VybmVsL2NwdS5jOjE5NQogY3B1aHBfdGhyZWFkX2Z1bisweDQw
Zi8weDg3MCBrZXJuZWwvY3B1LmM6MTEwNQogc21wYm9vdF90aHJlYWRfZm4rMHg1NDYvMHhhNTAg
a2VybmVsL3NtcGJvb3QuYzoxNjAKIGt0aHJlYWQrMHg3M2UvMHg4YzAga2VybmVsL2t0aHJlYWQu
Yzo0MzIKIHJldF9mcm9tX2ZvcmsrMHg0YjQvMHhhMzAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3Mu
YzoxNTgKIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMCBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82
NC5TOjI0NQogPC9UQVNLPgpNb2R1bGVzIGxpbmtlZCBpbjoKLS0tWyBlbmQgdHJhY2UgMDAwMDAw
MDAwMDAwMDAwMCBdLS0tClJJUDogMDAxMDpiaXRtYXBfZm9sZCsweDVlLzB4YjAgbGliL2JpdG1h
cC5jOjcxMwpDb2RlOiAzMSBmNiBlOCBhNSA0ZSAyMCBmZSA0MSA4OSBkYyA0NCA4OSBlYSA0YyA4
OSBmNyA0YyA4OSBlNiBlOCA4NCBmMiAwMSAwMCA0OSA4OSBjNSA0NCAzOSBlYiA3NiAyZCBlOCBm
NyBmYyBiOSBmZCA0NCA4OSBlOCAzMSBkMiA8Zjc+IDc0IDI0IDA0IDg5IGQ1IDg5IGQwIGMxIGU4
IDA2IDQ5IDhkIDNjIGM3IGJlIDA4IDAwIDAwIDAwIGU4IDM5ClJTUDogMDAxODpmZmZmYzkwMDAw
MTZmNTIwIEVGTEFHUzogMDAwMTAyNDYKUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAw
MDAwMDAwMDA0MCBSQ1g6IGZmZmY4ODgxMDI2YTAwMDAKUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJT
STogMDAwMDAwMDAwMDAwMDA0MCBSREk6IGZmZmY4ODgxMjZmNmYyMTgKUkJQOiBmZmZmYzkwMDAw
MTZmNjMwIFIwODogZmZmZmM5MDAwMDE2ZjVhNyBSMDk6IDAwMDAwMDAwMDAwMDAwMDAKUjEwOiBm
ZmZmYzkwMDAwMTZmNWEwIFIxMTogZmZmZmY1MjAwMDAyZGViNSBSMTI6IDAwMDAwMDAwMDAwMDAw
NDAKUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogZmZmZjg4ODEyNmY2ZjIxOCBSMTU6IGZmZmZj
OTAwMDAxNmY1YTAKRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4ODgyYWJjYzQw
MDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAw
MDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCkNSMjogMDAwMDdmY2Q4YzljNmZlOCBDUjM6IDAwMDAw
MDAxOTI3NTgwMDAgQ1I0OiAwMDAwMDAwMDAwNzUwZWYwClBLUlU6IDU1NTU1NTU0Ci0tLS0tLS0t
LS0tLS0tLS0KQ29kZSBkaXNhc3NlbWJseSAoYmVzdCBndWVzcyk6CiAgIDA6CTMxIGY2ICAgICAg
ICAgICAgICAgIAl4b3IgICAgJWVzaSwlZXNpCiAgIDI6CWU4IGE1IDRlIDIwIGZlICAgICAgIAlj
YWxsICAgMHhmZTIwNGVhYwogICA3Ogk0MSA4OSBkYyAgICAgICAgICAgICAJbW92ICAgICVlYngs
JXIxMmQKICAgYToJNDQgODkgZWEgICAgICAgICAgICAgCW1vdiAgICAlcjEzZCwlZWR4CiAgIGQ6
CTRjIDg5IGY3ICAgICAgICAgICAgIAltb3YgICAgJXIxNCwlcmRpCiAgMTA6CTRjIDg5IGU2ICAg
ICAgICAgICAgIAltb3YgICAgJXIxMiwlcnNpCiAgMTM6CWU4IDg0IGYyIDAxIDAwICAgICAgIAlj
YWxsICAgMHgxZjI5YwogIDE4Ogk0OSA4OSBjNSAgICAgICAgICAgICAJbW92ICAgICVyYXgsJXIx
MwogIDFiOgk0NCAzOSBlYiAgICAgICAgICAgICAJY21wICAgICVyMTNkLCVlYngKICAxZToJNzYg
MmQgICAgICAgICAgICAgICAgCWpiZSAgICAweDRkCiAgMjA6CWU4IGY3IGZjIGI5IGZkICAgICAg
IAljYWxsICAgMHhmZGI5ZmQxYwogIDI1Ogk0NCA4OSBlOCAgICAgICAgICAgICAJbW92ICAgICVy
MTNkLCVlYXgKICAyODoJMzEgZDIgICAgICAgICAgICAgICAgCXhvciAgICAlZWR4LCVlZHgKKiAy
YToJZjcgNzQgMjQgMDQgICAgICAgICAgCWRpdmwgICAweDQoJXJzcCkgPC0tIHRyYXBwaW5nIGlu
c3RydWN0aW9uCiAgMmU6CTg5IGQ1ICAgICAgICAgICAgICAgIAltb3YgICAgJWVkeCwlZWJwCiAg
MzA6CTg5IGQwICAgICAgICAgICAgICAgIAltb3YgICAgJWVkeCwlZWF4CiAgMzI6CWMxIGU4IDA2
ICAgICAgICAgICAgIAlzaHIgICAgJDB4NiwlZWF4CiAgMzU6CTQ5IDhkIDNjIGM3ICAgICAgICAg
IAlsZWEgICAgKCVyMTUsJXJheCw4KSwlcmRpCiAgMzk6CWJlIDA4IDAwIDAwIDAwICAgICAgIAlt
b3YgICAgJDB4OCwlZXNpCiAgM2U6CWU4ICAgICAgICAgICAgICAgICAgIAkuYnl0ZSAweGU4CiAg
M2Y6CTM5ICAgICAgICAgICAgICAgICAgIAkuYnl0ZSAweDM5Cgo8PDw8PDw8PDw8PDw8PDwgdGFp
bCByZXBvcnQgPj4+Pj4+Pj4+Pj4+Pj4+Cgo=
--00000000000079ab2e0652e4dbd5--

