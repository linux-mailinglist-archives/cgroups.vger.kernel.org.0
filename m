Return-Path: <cgroups+bounces-16146-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKq/Fx67DmrBBgYAu9opvQ
	(envelope-from <cgroups+bounces-16146-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 09:58:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 604245A0855
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 09:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4A8A303F6B6
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 07:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC11833F5A2;
	Thu, 21 May 2026 07:54:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123601D432D;
	Thu, 21 May 2026 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350059; cv=none; b=ZrPgaUZNaqBKvR3otnWcV1t+go09rt4KBh4r3aIKZg+EuHBD7n8d73+A+1I5vJP4mCCCLs4P9ZRgbR1OAYcznI6WKyNj8sE0Bnpc9P5Mr/7mahFBrxqQzPLySKLv7N+/tVWlOgWQASntvSQ9pcM+9q2XUB1RMZYJJTVKTPAAkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350059; c=relaxed/simple;
	bh=8dFQhSrPgLGdp5wbPpNKxYeHpPZO/Mfa2Yg7BD37zgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJ/uOg6XQAR52BTxPBUWuMIyN/SucEOYygWJXNNGgmRZdGrSItMLpEPE7N8HLFkUXGtMbo2j4eXpW+qTyoFQuW0m326cBYm/TzUMasna9qpC7cNFB2BmOpxz9SL+c1E1I9XB7VgtIXSw4+s/9JgNcAqRu9Sw/unvdFc5t+8BOhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 40cec12054ea11f1aa26b74ffac11d73-20260521
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:532e35bd-e6a2-46ea-817b-1b2810f5a423,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:532e35bd-e6a2-46ea-817b-1b2810f5a423,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:e590074133f47be07a94fc1eb35f04e2,BulkI
	D:260520203343UF2G41NA,BulkQuantity:9,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 40cec12054ea11f1aa26b74ffac11d73-20260521
X-User: cuitao@kylinos.cn
Received: from [192.168.108.130] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 740294230; Thu, 21 May 2026 15:54:11 +0800
Message-ID: <f981747e-2abb-47b4-9707-a846e450c662@kylinos.cn>
Date: Thu, 21 May 2026 15:54:06 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-throttle: schedule parent dispatch in tg_flush_bios()
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: axboe@kernel.dk, cgroups@vger.kernel.org, josef@toxicpanda.com,
 linux-block@vger.kernel.org, tj@kernel.org
References: <ag2owaQQoigp_fSV@shinmob>
 <20260520142022.1799724-1-cuitao@kylinos.cn> <ag5DjOCrzfD7D_Ln@shinmob>
 <31179261-64e0-4950-b112-32627d48e734@kylinos.cn> <ag6OXDuTc3JubfqV@shinmob>
From: Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <ag6OXDuTc3JubfqV@shinmob>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16146-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 604245A0855
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hello,

I was able to reproduce the failure and have identified the root cause.

在 2026/5/21 12:54, Shin'ichiro Kawasaki 写道:
>> If the issue persists after running with LC_ALL=C ./check throtl/004, I'll investigate further.
> 
> It still fails with LC_ALL=C.
> 
> # LC_ALL=C ./check throtl/004
> throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
>     runtime  1.250s  ...  1.211s
> throtl/004 (sdebug) (delete disk while IO is throttled)      [failed]
>     runtime  2.518s  ...  2.271s
>     --- tests/throtl/004.out    2026-03-20 14:25:50.478000000 +0900
>     +++ /home/shin/Blktests/blktests/results/nodev_sdebug/throtl/004.out.bad    2026-05-21 13:46:36.676000000 +0900
>     @@ -1,3 +1,2 @@
>      Running throtl/004
>     -Input/output error
>      Test complete
> 

What the patch intends to fix

tg_flush_bios() schedules pending_timer on the child tg's own service_queue.
For leaf cgroups, the child's pending_tree is empty, so the timer fires but
dispatches nothing. The throttled bio remains stuck in the parent's
pending_tree, but the parent's timer is never rescheduled. This causes tg
residual in the parent's rb tree and uncontrolled dispatch latency (~500ms
before the fix vs ~30ms after, in my testing).

Why throtl/004 fails for scsi_debug

The patch changes the dispatch timing: bios are now dispatched immediately
through the parent instead of waiting for the parent timer to fire naturally.

I looked at the SCSI device deletion flow (please correct me if I'm wrong):

__scsi_remove_device()
  -> scsi_device_set_state(SDEV_CANCEL)        // step 1
  -> device_del() -> sd_remove() -> del_gendisk() -> __del_gendisk()
       -> __blk_mark_disk_dead()               // sets GD_DEAD
       -> blk_throtl_cancel_bios()             // schedules dispatch
  -> scsi_device_set_state(SDEV_DEL)           // step 2
  -> blk_mq_destroy_queue()

Without the patch: 
  bios remain in the parent's pending_tree and are
  dispatched only after the SCSI device has transitioned to SDEV_DEL (step 2).
  scsi_device_state_check(SDEV_DEL) returns BLK_STS_IOERR (EIO).

With the patch: 
  bios are dispatched immediately and reach the SCSI layer
  while the device is still in SDEV_CANCEL (between steps 1 and 2).
  scsi_device_state_check(SDEV_CANCEL) falls into the default case, which
  returns BLK_STS_OFFLINE (ENODEV).

The FULL output confirms this:

# nullb (passes)
dd: error writing '/dev/dev_nullb': Input/output error

# sdebug (fails)
dd: error writing '/dev/sda': No such device

Possible fix directions
- Revert and redesign: 
  revert and fix the original latency/residual issue differently.
- Fix SCSI layer: 
  make scsi_device_state_check() return BLK_STS_IOERR for SDEV_CANCEL 
  to match SDEV_DEL behavior. This requires SCSI maintainer approval.
- Fix blk-throttle cancel path: 
  have blk_throtl_cancel_bios() directly complete bios via bio_io_error() 
  instead of going through the SCSI submission path. This requires distinguishing 
  device deletion (fail with EIO) from cgroup removal (dispatch normally since the device is still alive).

I prefer the third approach. The semantics of blk_throtl_cancel_bios are precisely "cancel the bios", 
and completing them directly with -EIO is more logical than detouring through the SCSI layer. 
We could either add a parameter to tg_flush_bios() or introduce a new dedicated function to handle the device removal scenario.

Does anyone have other ideas?

Thanks,
Tao

