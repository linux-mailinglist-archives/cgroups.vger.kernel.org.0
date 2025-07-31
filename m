Return-Path: <cgroups+bounces-8948-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368ACB16BF7
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 08:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B8A3B0442
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 06:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB03242927;
	Thu, 31 Jul 2025 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U5liEMpJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9E6R/+VS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U5liEMpJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9E6R/+VS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5CA190692
	for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753942629; cv=none; b=iBDI8kanhFmDQdvWkrVIAAZrWkBO8IQC4O2dmM4shJWrNO26/eH1Q4/svLdH73GE0c737X39w5MVxLh1fuzAivD+l8mZlcY5QqE1qYUAKo/1AiefVywXXcDYV2VpAe2nqZgy1IvQKKvFvn/ssTWT3C2mnqXZB6wxwBXINZCZHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753942629; c=relaxed/simple;
	bh=x/7ISYe+ra92U7mEGKum1EGwAI6PhKEhNlWjSeeslwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tx+1LsfRAnh2iugSknCuGsAbWHxQdTpvkvsCzRbnJ/my0cubVA5aqi8S+r5MLhfO7N30nG7tYoYF4nbGdQorNtADvEJJAxiCAArVOP4eTmtzdJlyyXE4lkAw7Ax9CXzHZ8E8Z2zG4K6Mlta7fpy+nNOBl0/oBVHkiCSGoAZ1Zvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U5liEMpJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9E6R/+VS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U5liEMpJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9E6R/+VS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4509621AD0;
	Thu, 31 Jul 2025 06:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753942626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzKTYAqAl9fpWihL/+OJ3DluaJ+8rt7w9fbrtBjG12E=;
	b=U5liEMpJQ33BzBuEnWnIZ3KFPUPDhDMRoq4mZheQcLOXBzzPfnqUKH6xVPlIrtci8ZEQPQ
	SZu9mE03GA07VxlOwJRRdll/PAMzbR+1lyyRvvwTa21QaOJqO/1mqwTb6DD4TI1f6p4O76
	Mbr7L4u8ZJhO0FvO8I8juLsizBVW2j0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753942626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzKTYAqAl9fpWihL/+OJ3DluaJ+8rt7w9fbrtBjG12E=;
	b=9E6R/+VSaoahAxF8mRUTl6WdUwV1xMLmIBOzv8qusnCHPNTrI8VElQzMAtrNCwzSP8aV94
	It1hNqlIXTNXeDAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753942626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzKTYAqAl9fpWihL/+OJ3DluaJ+8rt7w9fbrtBjG12E=;
	b=U5liEMpJQ33BzBuEnWnIZ3KFPUPDhDMRoq4mZheQcLOXBzzPfnqUKH6xVPlIrtci8ZEQPQ
	SZu9mE03GA07VxlOwJRRdll/PAMzbR+1lyyRvvwTa21QaOJqO/1mqwTb6DD4TI1f6p4O76
	Mbr7L4u8ZJhO0FvO8I8juLsizBVW2j0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753942626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzKTYAqAl9fpWihL/+OJ3DluaJ+8rt7w9fbrtBjG12E=;
	b=9E6R/+VSaoahAxF8mRUTl6WdUwV1xMLmIBOzv8qusnCHPNTrI8VElQzMAtrNCwzSP8aV94
	It1hNqlIXTNXeDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF52F13876;
	Thu, 31 Jul 2025 06:17:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jfQvMWEKi2h+WgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 31 Jul 2025 06:17:05 +0000
Message-ID: <05c6e25d-4c61-417d-b916-7e91f5195b39@suse.de>
Date: Thu, 31 Jul 2025 08:17:05 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] blk-mq-sched: introduce high level elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, dlemoal@kernel.org, jack@suse.cz,
 tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250730082207.4031744-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/30/25 10:22, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, both mq-deadline and bfq have global spin lock that will be
> grabbed inside elevator methods like dispatch_request, insert_requests,
> and bio_merge. And the global lock is the main reason mq-deadline and
> bfq can't scale very well.
> 
> While dispatching request, blk_mq_get_disatpch_budget() and
> blk_mq_get_driver_tag() must be called, and they are not ready to be called
> inside elevator methods, hence introduce a new method like
> dispatch_requests is not possible.
> 
> Hence introduce a new high level elevator lock, currently it is protecting
> dispatch_request only. Following patches will convert mq-deadline and bfq
> to use this lock and finally support request batch dispatching by calling
> the method multiple time while holding the lock.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-mq-sched.c | 6 ++++++
>   block/elevator.c     | 1 +
>   block/elevator.h     | 4 ++--
>   3 files changed, 9 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

