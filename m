Return-Path: <cgroups+bounces-16349-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLaaCCkCF2o70wcAu9opvQ
	(envelope-from <cgroups+bounces-16349-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 16:39:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 900FF5E60D1
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 16:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0652303D2F3
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959542668E;
	Wed, 27 May 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="TYMJkmNK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A8410D30
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892686; cv=none; b=IvkiELBuTrT+n8DNC9g38B5qQNPawlEdjKvGA7IeSori7gyfRpfzZLSoioa/kWowMObc9k75UnuD7RJA/FN5xtt2hrZ45EAIv9hdbuo6dBFM8wA6GJN0nMxjRLxFavJg4ww7vmmiomYQOIZEXjpirXtSsxWaPMzIdz8QpMSD36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892686; c=relaxed/simple;
	bh=/UrVToUCN1/dFd9xlbwyZOXPSWDC8n0F587aoKesJTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U5/kqEgMH7spyGJK+Ip2a94A2g22q9WAcS18sGuGtdexEODAlKKqjulSGEkAGEjfNysoB8floQjtRR9bDt03JS87OyWRAOV7+7NVQMAudzCDm3gQLQYU3iEqPhj3x3ZHHy+RrKUpo0UB0ltKIFLR8FX54lMVlanJ8ogMk/XrcN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=TYMJkmNK; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dcd17e19b6so6631506a34.1
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779892684; x=1780497484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqdZyQ8TepaAQlegTcjHUyFuT9L+aZqIlpDGn7XrdU4=;
        b=TYMJkmNK70rtnNf3wttlrWdJb+7NUATnxHQJfA0604qnUOv2FTghGuh6vG+Ny99M/E
         F2tSyQEPA8GDYJVs/eVrxarcwqyyQtebTC1+mJsNt6Gb1vPoOSK23ArTkAohrHdckzxG
         IbJCci4RbkYGy3/oJW4w5AI6rBlUvJUtHrKGbdS7qZlhnXLr0dfu0Zk186XKrdPtTfAA
         /GfysEW0nA5YSw/PtHi9y2x/5Ncq6t8NgztYflIZBsE+jUpKxnoHPS/VZkCn/NwmExWu
         uiJZtVrd1zGnHouLR6VxYn1I68KgH8ZcveFMpBBOKqjwi16j/+SsuppiH62mdzFVyx8S
         AZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892684; x=1780497484;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KqdZyQ8TepaAQlegTcjHUyFuT9L+aZqIlpDGn7XrdU4=;
        b=sVOGf0pqzWPGhpsuQcrsW/32OFNf8sZl6IwqOWavHh9G7kdjcJagoovLYBMNfgU+Dr
         87bu5CPKq8LFZtzI1c2ooM9l/nGikR+pvQjRKgZiQEAm3ZFzBovRr4b+/w572/sTt6Yg
         2D0tgM7syLggJOJHuCMbPLCWbdDof109aHdrCqB3S9b4CjWEn828EfuFUsxcsdX0Hw4O
         MjA/xr8qdxq+YZFnAa7ZjT1hVSmP+GY/nHW/pIrxyV4mhuh2SkzQXGxHCnVAtVcm6jll
         bIB0xSeuDk3tBSr6JXwGnHGHV4AhDs5rYijW5ArVIMIEDYd0sDaGq8kLZVfTwnV3R5MM
         eElw==
X-Forwarded-Encrypted: i=1; AFNElJ87gVlE6qVAJdd8vYDNB3BnFblzZ1JSTPyZYc669JZnMKy2LvfpvEMpr4PHAr6SQvm6UzQVuCMB@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+SRAeImmJM3FByRi/5wwwRQP3EGx9W88RKW3khFgolpoYEbc
	BsLH2xYAskM7bo2zLonuSVKuhvZyaQqAG60CwAi7O6ohm1lPH3ncO03Vtr/IbxMc74c=
X-Gm-Gg: Acq92OH8AmozNfJAwZ0QpIZ6xbj/ZWvY+dLrroV/h6vWtBzAwNqzXR3VdvMro8LsNNr
	Ypk3wppOZAG1KB5DjYwYs56prJCU87omVzXh3t/fpKU//kmVRWDl3PV1z4xxoslmoB1Ai1/VEQO
	68Qdp4BDQWdaaa9mohYa/fV8NRxof2hTcM/+w/9QXopC7wLDD0hlUXPgrInQWGLGFcfOWQFS1iy
	4P8L8V0ueh6eCE0kPtdODEPtrZj87T2T9sg+V8Sw4OhC6RBJl9AxypUQkAy5O/0Ue/VZBmv4Wzq
	u7zYAF6LpTNOZimOIMoj7wKQpN32PgHl8b67WLfd0Do5pxjgUAyi0wrFVm+hggadaY476VcppOr
	66AFom0GY5odrGQVEpxwo3qQacsM/+QHRe6vEA11aTd6MX8umCT0qiiC/dMqegDi2Apth8gQH+7
	Eb51sBkWg/GtbtfdzC/PE39cuATUQ7qFCOYRItLxakoF4Qrt2N6UPirW0ZgIU8u5TsEHIWMd3AG
	0E=
X-Received: by 2002:a05:6820:4c83:b0:694:8c46:e2c3 with SMTP id 006d021491bc7-69d7eb6b527mr11938897eaf.14.1779892683791;
        Wed, 27 May 2026 07:38:03 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b6351a772sm16950878fac.3.2026.05.27.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:38:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, cgroups@vger.kernel.org, 
 Tao Cui <cuitao@kylinos.cn>
Cc: linux-block@vger.kernel.org, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260522091530.1901437-1-cuitao@kylinos.cn>
References: <20260522091530.1901437-1-cuitao@kylinos.cn>
Subject: Re: [PATCH v2] blk-throttle: schedule parent dispatch in
 tg_flush_bios()
Message-Id: <177989268208.742656.5047337286671399342.b4-ty@b4>
Date: Wed, 27 May 2026 08:38:02 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16349-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 900FF5E60D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 22 May 2026 17:15:30 +0800, Tao Cui wrote:
> tg_flush_bios() schedules pending_timer on the child tg's own
> service_queue, which causes throtl_pending_timer_fn() to dispatch from
> the child's pending_tree.  For leaf cgroups this tree is empty, so the
> timer fires and exits without dispatching the throttled bio.
> 
> The throttled bio sits in the parent's pending_tree with disptime set
> to jiffies (THROTL_TG_CANCELING zeroes all dispatch times), but the
> parent's timer is never explicitly rescheduled.  The bio only gets
> dispatched when the parent timer eventually fires at its previously
> scheduled expiry.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: schedule parent dispatch in tg_flush_bios()
      commit: 6235ea3f8b8ffca0333ade0863992f3cd69592ea

Best regards,
-- 
Jens Axboe




