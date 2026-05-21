Return-Path: <cgroups+bounces-16149-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG/wLkDLDmovCQYAu9opvQ
	(envelope-from <cgroups+bounces-16149-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 11:07:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 348EE5A1E0E
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 11:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37BC4302F554
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317A8366541;
	Thu, 21 May 2026 09:05:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C776B175A8F;
	Thu, 21 May 2026 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354304; cv=none; b=ehA79CfaUiWK6nqWRrN6bml8AbWTihLe0JJApZqvUVnsEwSbjtgFQVgwuWYpT7dISRoUaEbXJTuq32DKKZTBR/ohhYHRVtNQlhNTqVfYV5w0YnEMKYpgz7HPvWtu/w/DVfMe6vtEbyJ0xpH8jU9mXQvgALvvAYPj1a/KjeYNdMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354304; c=relaxed/simple;
	bh=qCwCAijqdvdP9Oi+hkkTLPF71BM6kp8lP+BjhPBtVg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olSehylGEcsDjwnZEqv9Ran0h7xguWihOsYGF0tji5GY0ckX7CgQXnyuW85M6UqqN/3PENfqYNuSpDj0ZMeDGPZ2sNrI28vWg257PYBdk9X8zg7yHUj2vMrVH+Lu78eXPp1qrXVAsO+3HNHBn7H6buVcjZt7GGFsIezolnAjJ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 21c3cb4054f411f1aa26b74ffac11d73-20260521
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1e747207-1168-4520-8ae7-854bf1909505,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:1e747207-1168-4520-8ae7-854bf1909505,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:08995bd8fb7bc2b15f05408dc435ee31,BulkI
	D:260520203343UF2G41NA,BulkQuantity:11,Recheck:0,SF:17|19|66|78|81|82|83|1
	02|127|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 21c3cb4054f411f1aa26b74ffac11d73-20260521
X-User: cuitao@kylinos.cn
Received: from [192.168.108.130] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 803809240; Thu, 21 May 2026 17:04:54 +0800
Message-ID: <5d59c249-5e8d-482d-bb83-11f6ed6e0e8c@kylinos.cn>
Date: Thu, 21 May 2026 17:04:49 +0800
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16149-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 348EE5A1E0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello，

Following up on my analysis, I did some further investigation into
why I couldn't reproduce the failure locally.

The root cause is a timing-sensitive race between the dispatch and
SCSI state transition. Whether the race manifests depends on kernel
build configs that affect execution speed.

在 2026/5/21 12:54, Shin'ichiro Kawasaki 写道:

>> If the issue persists after running with LC_ALL=C ./check throtl/004, I'll investigate further.
> 
I found the following key differences between my config and the
Fedora debug config:

  Config                    Mine    Fedora
  CONFIG_PREEMPT            n       y
  CONFIG_KASAN              n       y
  CONFIG_PROVE_LOCKING      n       y
  CONFIG_DEBUG_PREEMPT      n       y
  CONFIG_DEBUG_SPINLOCK     n       y
  CONFIG_LOCKDEP            n       y
  CONFIG_DEBUG_KMEMLEAK     n       y

KASAN and lock debugging slow down the __del_gendisk() path
significantly. This gives dispatch_work enough time to run and
submit bios while the device is still in SDEV_CANCEL, triggering
the BLK_STS_OFFLINE (ENODEV) response.

After disabling the first four options (CONFIG_PREEMPT, CONFIG_KASAN,
CONFIG_PROVE_LOCKING, CONFIG_DEBUG_PREEMPT) on the Fedora config,
the test passes:

throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
    runtime  0.763s
throtl/004 (sdebug) (delete disk while IO is throttled)      [passed]
    runtime  0.923s

This confirms the race is timing-sensitive and depends on the
kernel build config. The fix with bio_io_error() is still the
right approach -- it completes bios directly at the throttle
layer, avoiding the SCSI state check entirely.

Thanks,
Tao


