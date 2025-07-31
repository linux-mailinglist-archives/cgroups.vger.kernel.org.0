Return-Path: <cgroups+bounces-8950-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340ABB16C01
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 08:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994103B5B7B
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 06:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2111525486D;
	Thu, 31 Jul 2025 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DmEmoC5K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kuQ7jORt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DmEmoC5K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kuQ7jORt"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D83421B9E5
	for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753942935; cv=none; b=JhJXvN+4AMNe1OC9mTKFbRq2SBqhhqfLRaqXWrUaIZ6BJ2KT3hAjGuhm96WMGT+mpBzAjB/pQwgfFJ4/Af3ebm6zMftuZCOHGJgb1i1Uq3EDmyq59U/9WU2QVj+JgrMQ3fpb+zOoTzdzQpnoOE8v1PQ1cDoh5IB7SDwu59AmOPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753942935; c=relaxed/simple;
	bh=QaOgQXRhF2rval44ekY0vt27jFmbumIy3RrKR860maA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAIHFcfV5WonAmMXT1gK6769OHbogBur5QVvVRFX1GU3LJ0M2qk7RMiX26vEGoI0luFHM5oRqrDpNZoOebl+jbQ3IPmN4w4NDcDrjTRSgqCmmWvag1habGKzr0Jol37k//ToonuHbBqvg8jHwm9XyswJvuezj8e0RKGl044/enE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DmEmoC5K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kuQ7jORt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DmEmoC5K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kuQ7jORt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC6A621A4C;
	Thu, 31 Jul 2025 06:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753942931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpfKB441beCH/6Ta1OHdCqOz+HVLM7+9ygZo3asTKhc=;
	b=DmEmoC5KJ5KErPrFM+8m87PeBc7AMFQ23uCAyd2PLd5EG7zgdnROkUJlmXY/LgEZ1Yi+1e
	nqHEMswVXWlrbL1Qsi3S/6AcVUfWHk4gfzOWzw/lbxAhMJQ32VRLMRYOlUY4+6/RnQhxcq
	gPj6hL5IasBIoK22NjTOdWtI0LYFE2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753942931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpfKB441beCH/6Ta1OHdCqOz+HVLM7+9ygZo3asTKhc=;
	b=kuQ7jORtWIQiZBrhszPdiHMfv5DVk1SLtZEYw3h9aX2Xse0Xmxky5lICctQACCC8+GYk8v
	DFqaugryTIEHfRDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DmEmoC5K;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kuQ7jORt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753942931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpfKB441beCH/6Ta1OHdCqOz+HVLM7+9ygZo3asTKhc=;
	b=DmEmoC5KJ5KErPrFM+8m87PeBc7AMFQ23uCAyd2PLd5EG7zgdnROkUJlmXY/LgEZ1Yi+1e
	nqHEMswVXWlrbL1Qsi3S/6AcVUfWHk4gfzOWzw/lbxAhMJQ32VRLMRYOlUY4+6/RnQhxcq
	gPj6hL5IasBIoK22NjTOdWtI0LYFE2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753942931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpfKB441beCH/6Ta1OHdCqOz+HVLM7+9ygZo3asTKhc=;
	b=kuQ7jORtWIQiZBrhszPdiHMfv5DVk1SLtZEYw3h9aX2Xse0Xmxky5lICctQACCC8+GYk8v
	DFqaugryTIEHfRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 586DF13AA9;
	Thu, 31 Jul 2025 06:22:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o897FJMLi2j9WwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 31 Jul 2025 06:22:11 +0000
Message-ID: <74d697f7-f013-4067-acd2-e0f080dc51fa@suse.de>
Date: Thu, 31 Jul 2025 08:22:11 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] block, bfq: switch to use elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, dlemoal@kernel.org, jack@suse.cz,
 tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-4-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250730082207.4031744-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: AC6A621A4C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 7/30/25 10:22, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Replace the internal spinlock bfqd->lock with the new spinlock in
> elevator_queue. There are no functional changes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/bfq-cgroup.c   |  4 ++--
>   block/bfq-iosched.c  | 49 +++++++++++++++++++++-----------------------
>   block/bfq-iosched.h  |  2 +-
>   block/blk-mq-sched.c |  4 ++--
>   4 files changed, 28 insertions(+), 31 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

