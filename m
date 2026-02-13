Return-Path: <cgroups+bounces-13947-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEZHJb4Sj2khHwEAu9opvQ
	(envelope-from <cgroups+bounces-13947-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 13:02:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC4135EC4
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 13:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA78D300D75D
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 12:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B835CBAA;
	Fri, 13 Feb 2026 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px0oKfRD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A77332548B
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770984119; cv=none; b=dzKnDnehpiTuzN1vf0SpXAzWBbSyz+qDefh7TYikX1KtblnMKIkmjOcIxK82NRTB/4Vb7IyFXAftEXz+8zuw51W8eFfHwwRdqmwkDKfIjRiwYG2TiUuAgHQPkFCWEQY6xfYhfGszTO8MoLiJSN6kw4rXDmIC9NAL0aqRdquYgnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770984119; c=relaxed/simple;
	bh=24HytnqXY2IQ2pdZhMjqMPeei8eSC1wSFaCSqZdU8kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BONiSBO5UJbc+jdTYCQiawxgK4+YuCuQGjyoIG/4hnk/BgavZD7DpFPKOaorm9tccEu1GjubIPj5SsvDyf2QMsK5MndrTDk2cMlfDNALVZB63RN/aRJ5U/joFistCYqyOWkwOjdwkum0dePV6h4OYxs0L0V7Y0FiL5DeSZ7K7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px0oKfRD; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-824484dba4dso841026b3a.0
        for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 04:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770984118; x=1771588918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3QccyLBzZLEl0LwWVPZnt4xrcGiKN2vu1maCig+39c=;
        b=Px0oKfRD/9R08gocex+A9C7rK1xDsjqZqV1ACf0x+LsR10iuw5357qNZAWsrFjTQBk
         vsk6MwUMXPo7KUsBhwmBWl9TF8lH62EiBGTHLN7/NWuR6kN1hwUdG9e1dNSApq9itaFV
         /D6uSZZaHlA+U9BeYipTNxxh1KYxHWhb+vcCb3K+pDWfWZxRNn8rJYGYQyJXUNH6WlPN
         MsFN8sroslIyXYPIFWwkyE2c5AXAqLEIKovRz0vRj6XVSe/QepBwy5UvNkB/gZofjKty
         1RPo1mrv3LDvgDglhMnDMAvDIzVC08UjYZPys7Vql8HAuLU1Jp2lRM588Kah2VBb/6YP
         636g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770984118; x=1771588918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O3QccyLBzZLEl0LwWVPZnt4xrcGiKN2vu1maCig+39c=;
        b=ZiUfsz2pkJ3Xe2Ml/MA+dCL1FiDFo/Ud7jM60UwToWinrI6ze6WrJez+H9WXvNLG3I
         akaRO31+xNwVmVTwCQXflrw4jQdlnz1jVulpfnJfzq8nwBDdsUv7cmwAj3hyO4u/NyI9
         T/lKJjQ8sZDe5N3ABIDMDFIBR3AFb6zBtQ235a8dfNE4jQ3jkCMrCsRxmOy5MMwjP+7J
         ASuiWjOAO+5HcuCFvAapMRtjFh3pZHkjrNTclrMfJSolXAXrTV7OisvCHEsJ56+SyJOJ
         QWF6JPJ8g0tm/nG++MM9X0PRRYOteckBAan0A/HEnx+FfSNq/QzlIdjiVsaYiOS2HOQD
         77Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUeOakChbGLMb47Oz0t0JS659qcJlCP3KCA3xohOflWTcLnBw17XRg3jDLPugwPZ+/xPGLsiEjv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7oj/wEseiNSQiE0d1c++akZCJpS2lXW3l97Z4XqIP5ak4Y3l
	0Jo9eTwVpfoXdkT0MGcNLlzzh+wdrscf5bjrqs7gXLQo+Pe9Uc0k2ugI
X-Gm-Gg: AZuq6aL9EpZrZNcbSqemmA0oWN6WieGYRH6YJ/1ZW265Z16YMb7giI/gfskpY3vlIRo
	il0zy/A2765anQj6IckMBOELWXHByFJsJHRE3pMq3zfnZgcGwyVubJEb2269w2rE1d6v9hkCPCK
	UE1dA37QjfrHW7DRCe0kzc1+jcty65gynL0NkaU0NmPO7POdw7CXhE/Ysh5kjpsePeHZyK6D5ZL
	LMnVvfHBzZH8aCzSRCsgO38x1fdLOpGpvN1VQmj99jpAthcViTSUmWbcAldqRcOUOlaCCjGEXPB
	ML24aCQ3uHCEylh0irt+AbJch+1/7bfBHOfIXF05V+vd5N9m87DJT/jqm+CTNFo0Eww0ojyhaIp
	Ma/orOedksqsVXLGMqYKSSYHtmY2O+srrjBPm7hPvZJrfnfWtye4AzgzIroDQHq2O7lvEfrYuc3
	N8a+hnWzARNKBzTjSBDm4aQKjhA/hm6Y5eSg==
X-Received: by 2002:a05:6a00:4f87:b0:823:9c6:1985 with SMTP id d2e1a72fcca58-824c948163bmr1706633b3a.16.1770984117386;
        Fri, 13 Feb 2026 04:01:57 -0800 (PST)
Received: from archwsl.localdomain ([223.166.78.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a4316fsm3180723b3a.23.2026.02.13.04.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 04:01:56 -0800 (PST)
From: Jialin Wang <wjl.linux@gmail.com>
To: wjl.linux@gmail.com
Cc: axboe@kernel.dk,
	cgroups@vger.kernel.org,
	josef@toxicpanda.com,
	lianux.mm@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org
Subject: Re: [RFC PATCH] blk-iocost: introduce 'linear-max' cost model for cloud disk
Date: Fri, 13 Feb 2026 20:01:47 +0800
Message-ID: <20260213120147.322797-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213094218.253536-1-wjl.linux@gmail.com>
References: <20260213094218.253536-1-wjl.linux@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.dk,vger.kernel.org,toxicpanda.com,gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13947-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wjllinux@gmail.com,cgroups@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[wjllinux.gmail.com:query timed out];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 83FC4135EC4
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 5:42 PM Jialin Wang <wjl.linux@gmail.com> wrote:
> > This formula correctly models the dual-bucket behavior of cloud disks.
> > It ensures that for any block size, the calculated cost aligns with the
> > actual bottleneck (IOPS or BPS). This allows the system to reach close
> > to the provisioned BPS/IOPS limits without premature throttling, while
> > still maintaining the latency protection benefits of iocost.
> 
> This model still has some limitations. Under workloads with mixed IO sizes and
> vrate max at 100%, it fail to fully saturate the hardware performance.
> However, it still demonstrates a clear improvement over the linear model.
> 
> The following fio benchmarks were conducted with two cgroups assigned equal weights:
> 
> Cgroup A: fio --bs=32k ...
> Cgroup B: fio --bs=1M  ...
> 
> Results:
> 
> Model       | Cgroup A (32k)         | Cgroup B (1M)        | Total
> ------------+------------------------+----------------------|----------------------
> linear      | 1137 IOPS (35.5 MiB/s) | 79 IOPS (79.5 MiB/s) | 1216 IOPS 115.0 MiB/s
> linear-max  | 1781 IOPS (55.7 MiB/s) | 83 IOPS (83.9 MiB/s) | 1864 IOPS 139.6 MiB/s

One potential long-term solution might be to separate the accounting for IOPS
and BPS. By tracking two independent vtime counters (vtime_ios and vtime_bytes)
with their own weights, we could apply throttling based on the specific
resource being consumed. This would avoid cases where high-bandwidth requests
unnecessarily eat up the IOPS budget, and vice versa. I would love to hear your
thoughts on this idea. Is this a direction worth exploring, or would the added
complexity be a concern?

Thanks,
Jialin Wang

