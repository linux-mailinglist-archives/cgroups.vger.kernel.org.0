Return-Path: <cgroups+bounces-15142-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOpXIucnzGkmQgYAu9opvQ
	(envelope-from <cgroups+bounces-15142-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 22:00:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC00E370EE4
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 22:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76221302DF59
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 19:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFBB3FFAAA;
	Tue, 31 Mar 2026 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H3ZjUOQZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E01136EA9B
	for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987020; cv=none; b=n+XKka8w21E499URm0aOx6r33Px0I5QO5kK0o098+P1rxUgoZ0Fzue4QFQEas2nhWAO3+AqB0NebpUFzfFg5wZalLN1bLzywS7aljL8Cmz1yS1XUobKEmz9DYGFUQXDCEOBFoUdohzYBuP+ctlassXhSyFXclHLykJy7QRaPuq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987020; c=relaxed/simple;
	bh=VTzvTtXw9O3a7Ncm00wfZnRJmSE/UFChHeLAcBxav1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GKXsdMZPOq/dKrozlcPm8e8ZPQZkJY3W3DveTwnwM7yVS3waMKFAO0staj8DlgOtriSifJcVV5/3uejNCEqslbbIHWfj5ZMzZPZKNN5Db0DE3wy8jjb1v8MfB2gnNBAnfRxGriDU1AUSXOEUvO25x4cd+hp+WxBeprTsD9nCLjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H3ZjUOQZ; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40423dbe98bso2389878fac.2
        for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774987017; x=1775591817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rDDb+e5vufvBziWDb34wMohzuO8IwsVxGEyjZ/xAZk=;
        b=H3ZjUOQZDJ70k+VfVcJH/3fJVGKv+lDY0dG+zCfFuFSN0CqzniVZfYb9jbG+Y4PGlM
         lhcTJ4eOvIyN1p3roJvDNOnEirhB4JRx6H76nIX4ENHPB93tCJ+Q+C2lGLomjg9tZ1ry
         A8Ulw6M1g9ENH6YDXgpxDDHiu7qEDW5GrlEK8X1Y3OmcTUoldIdRcWM5ROIsvsbNq6VQ
         NmUVwcO3M0iXa+nuaDYRG4cbX3FCZFCHqjeDBdXmAoYSuFd7g3o+9aBjXUBk9IA/J1W6
         sOuYRqRFeQDxRkk6RzhbPv3SCflAIWw5FOZKxbd228r4sVmhb5mc+T7lazFwrpDJM1wX
         vf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774987017; x=1775591817;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9rDDb+e5vufvBziWDb34wMohzuO8IwsVxGEyjZ/xAZk=;
        b=chFpfGhzrdQGpkdXqx3jxLiPI3p8VZBo427MnmrDUZKl+fzMgQD3ES7T3IYWHQQwsi
         pqZDYEOiHgj7drHy3fdu75iGp2fkM/R9VxAFfbCW+ubld9xMiSHKUp7FedevZj/WO5py
         bX9aDEAB4Aklhv2PVSXhTFRTkqB0a3wvH1Db0YI+X2kO7uozU+gXi1KgCTp10+HksTyf
         SRlCXVVZZ4XmEiXqzKPYyuHjz8FyOdyIZCvjmUC5HQe4oqglqWGNsvDs78dyM7/o+/XF
         pjNxDoGAJmpEY+3z3TfJg2MiOrowtUWrT1MQyo7A3ZTqt9Jx7D/rOzxD0JiV5d17HdMJ
         5E3A==
X-Gm-Message-State: AOJu0YxP8uVi8iUMVZe3AzP1smXsDxUwpdcHiV5Uv2dM1dWCstyHrsPL
	LFDSdAzT5oDvrXw95OClp83vAR/WT3jjPqbz+MEohIUts7EGhH3Rf5D+hWzJMNNe5WU=
X-Gm-Gg: ATEYQzzmu4oZAco2WgM8GKAuK257USBnikE1tBQwSYIhMNz/B7pFlML9yiYBoe5tQnU
	k5QqbwrKQv5LcZmd0FQL1LRwJt2ilQt992bB2MzZ1i+ClM4V9elmYlD3scRzbsflIupRZXFG6Zy
	mX6Ov7Sq1sim+MppEm2lJsoSGceuR7n1xtRks9tB3+x4Wsit0SCtpCqpIx8q6Xl2MYoklk+UkOP
	KYvOgFHW7Kx+iBGEcFOtNPrcIWvTjsGkzlYYqM4UCWCaIHxig/imDwJ7/28sUJ63r2sXejI6aj9
	Y6A3WB/g4yjL1oVLGX/MZV1GsUFwwxcZQwtkJ6I0VPMy32915Asz6/6M6RO7gui5A0XzObiVP9P
	ScJN8+PO3ysszQ+OKjoCB1EhF/9jv2laktvryiZOmpkQfrtMs+M2ClSXmu65gQg1APF+uSbLp72
	JjE7IfWqWUBCqQ+Acnjk25F96dN5O2xlB584kSblGcMm87Ig7pAlcDIu23mrGBhU6LuTVq4jvth
	4U=
X-Received: by 2002:a05:6870:350d:b0:41c:c022:c180 with SMTP id 586e51a60fabf-422d0001018mr597860fac.47.1774987017392;
        Tue, 31 Mar 2026 12:56:57 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04c87973sm7780779fac.10.2026.03.31.12.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 12:56:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jialin Wang <wjl.linux@gmail.com>
Cc: cgroups@vger.kernel.org, josef@toxicpanda.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org
In-Reply-To: <20260331100509.182882-1-wjl.linux@gmail.com>
References: <20260331100509.182882-1-wjl.linux@gmail.com>
Subject: Re: [PATCH v3] blk-iocost: fix busy_level reset when no IOs
 complete
Message-Id: <177498701654.21640.6294974532543984458.b4-ty@b4>
Date: Tue, 31 Mar 2026 13:56:56 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15142-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC00E370EE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 31 Mar 2026 10:05:09 +0000, Jialin Wang wrote:
> When a disk is saturated, it is common for no IOs to complete within a
> timer period. Currently, in this case, rq_wait_pct and missed_ppm are
> calculated as 0, the iocost incorrectly interprets this as meeting QoS
> targets and resets busy_level to 0.
> 
> This reset prevents busy_level from reaching the threshold (4) needed
> to reduce vrate. On certain cloud storage, such as Azure Premium SSD,
> we observed that iocost may fail to reduce vrate for tens of seconds
> during saturation, failing to mitigate noisy neighbor issues.
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: fix busy_level reset when no IOs complete
      commit: f91ffe89b2016d280995a9c28d73288b02d83615

Best regards,
-- 
Jens Axboe




