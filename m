Return-Path: <cgroups+bounces-13966-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kObIJA5Fk2kP3AEAu9opvQ
	(envelope-from <cgroups+bounces-13966-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 17:25:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E06DD1461FD
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 17:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FA1A3036ED4
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 16:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6682B332902;
	Mon, 16 Feb 2026 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiyBTLVz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C923330B23
	for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258876; cv=none; b=utgTHxVCTqJDIGOBuhx4OslWxmbTAR787sSjd04zOR/QXkvNy3Wzck04UrKcIsu8/uyhMYoiyAH4yQyDfBTMl7E7x+99To4PqvUnslnEJCsIHbJL7dVUB+PvOiGMiNHatGOU22IfkxDYb9CDVESY9MDI4BovV20iRakCuBUVMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258876; c=relaxed/simple;
	bh=vXPwT/SWHN0vRTO+ghXErJHF9bFSJOc15B0GoDaOvpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6hMbqXQJOjsb1IzV6x0BVSUL0Dyw654OvtRlZjUCeOYvygckRm5bd9aJsIfeHb2Flp21+5Am6yvozvD32pLB9BJEVZd/CNDwqW5AX9PVZxpmL5Akunz6fOFZImDo2AjCO7SfSthFgXA9kNPyzI4J6DWYbi51sJT/CM6lTjSWHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiyBTLVz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4377174e1ebso2513616f8f.3
        for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 08:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771258873; x=1771863673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ScvhChnO4StcvknG4EO4W1y203NmQMeHjxbNv7iKKOc=;
        b=KiyBTLVzInkMAi/CTTsBXzdtQM5xQ8uoQ1/gZGO7ei8wx1zqB9/N8cXp9hJOhprJ1v
         bjP6qMPFcbP7ISs8U64ErDBG6PjP7jIxOKxsedNWU/yx9vtnibr+Jd7om+PAle3595rx
         jx/DrLDtRajQ5a9Has6ZIpY1KBT2goL0XUaFAT8cSRiLfxyIgwzD2GxHMO7a/BzATUj9
         spTx73ENgAkWjR8dUD/FjPIeQCv0E3lLdqAFPZXo8FV3n1r68I9QxTWSMzAMBIvjgvWp
         GbMilKWU98AWOTl4uJYn8lQZTMT+mqNTCXxFKE33UmsrM++k1iY/S9gLp/+wtQzn55iZ
         2+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771258873; x=1771863673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScvhChnO4StcvknG4EO4W1y203NmQMeHjxbNv7iKKOc=;
        b=tq0LRepKx9TRGkJ96pLV7XFnIOjS7mRDEor9Hq3EgXVSKJtH7FxCU2XITsEFLOmtqR
         CH0KGXQx3WNRPLHso3c0EGBo6R0UUpJe5xbcmd2jQqf9bq8S+Bhp7KTyKIjYWM3yt/TU
         y3atpIbjPl3s3n42fyeulux7Z+KEjOtFcoyZ2FWz810Z1cHPvk8DfhdhrKsNneJKWwOG
         bxNh3c4+e7FsMtPSxb+YGyhagKspdulVW4wtkgwT6gEz6SpwDPhyEYII2y6mbq8nZUCH
         axFMX+IEUQ0eFbNfdRmrErlYLz7FHFLzoGquy1rURmDOyasqY4xdQFbHSqstQ0PHMb99
         Xo8g==
X-Forwarded-Encrypted: i=1; AJvYcCXzTnE68uK6F/QA+zScf2y1fvPzUCSGTRKwH6eUuoIZazMoKW57nWeLnMRtBYwp6A1e0+t7o3pH@vger.kernel.org
X-Gm-Message-State: AOJu0YxvI89RoCul+8Qs4plULnZjqT1IT7AMyJKsKrbsUjClJUN5dJ84
	6VE0L16dVoLa6Mo5qs1qdnX09dt6o9rkNxv2bGzwBezsUu/UQWzKYvzu
X-Gm-Gg: AZuq6aKgUIkR2o1PdyyoBui0tS2dvwDezCtQp/qh1BdMXtSN/Zs+poGkUjds288kP22
	2chpXTlPzy7846LL5G8MCn03L7zz/6f1CS7Mbd2DhZylLLBfcpDqZcR7bkDv9ESVpwaoNCRXQCr
	9xoXS9A5WKby3Qyk0aTU+d+tT2YjddSPedNX+hu1LifBss0fgy6vOgQQWhshZnXO22OqGpGMEFy
	tM2kcVzMOIKIDbf8y1qG/Q14FBUD4bw2lM90okQzlOMx9Q4JfcYSE28FWWkBoNG/ARTvgPjeHu6
	AUiLZ0dwxEWCu1Ek4PWqihQ/qZl7tJDeVkGTuB1B8Kod09yCFNUKrhjXHMA9ExlHKX/hpYl/Y1f
	V8YdZdV1zRjUhJ2T6sh1ZN76SxCJmGgdrLTY0RisgTjjWVw2S688jxXSkbpCDy2NSWPEDcR1egP
	OWQvh0MFUZB8Lnb+TTnyxWmWF6CWpp+UXGkNPc2xxE2yqiyQSzmPW83tTo
X-Received: by 2002:a05:600c:8b32:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-483739fc64fmr193175955e9.7.1771258873226;
        Mon, 16 Feb 2026 08:21:13 -0800 (PST)
Received: from localhost (bzq-166-168-31-253.red.bezeqint.net. [31.168.166.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836cd7af87sm321885895e9.1.2026.02.16.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 08:21:12 -0800 (PST)
Date: Mon, 16 Feb 2026 18:21:11 +0200
From: Amir Goldstein <amir73il@gmail.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/3] kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED
 support for files
Message-ID: <aZNDSl3GPrNBGwmL@amir-ThinkPad-T480>
References: <20260212215814.629709-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212215814.629709-1-tjmercier@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13966-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,memory.events:url]
X-Rspamd-Queue-Id: E06DD1461FD
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 01:58:11PM -0800, T.J. Mercier wrote:
> This series adds support for IN_DELETE_SELF and IN_IGNORED inotify
> events to kernfs files.
> 
> Currently, kernfs (used by cgroup and others) supports IN_MODIFY events
> but fails to notify watchers when the file is removed (e.g. during
> cgroup destruction). This forces userspace monitors to maintain resource
> intensive side-channels like pidfds, procfs polling, or redundant
> directory watches to detect when a cgroup dies and a watched file is
> removed.
> 
> By generating IN_DELETE_SELF events on destruction, we allow watchers to
> rely on a single watch descriptor for the entire lifecycle of the
> monitored file, reducing resource usage (file descriptors, CPU cycles)
> and complexity in userspace.
> 
> The series is structured as follows:
> Patch 1 refactors kernfs_elem_attr to support arbitrary event types.
> Patch 2 implements the logic to generate DELETE_SELF and IGNORED events
>         on file removal.
> Patch 3 adds selftests to verify the new behavior.
> 
> ---
> Changes in v2:
> Remove unused variables from new selftests per kernel test robot
> Fix kernfs_type argument per Tejun
> Inline checks for FS_MODIFY, FS_DELETE in kernfs_notify_workfn per Tejun
> 
> T.J. Mercier (3):
>   kernfs: allow passing fsnotify event types
>   kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
>   selftests: memcg: Add tests IN_DELETE_SELF and IN_IGNORED on
>     memory.events
> 
>  fs/kernfs/dir.c                               |  21 +++
>  fs/kernfs/file.c                              |  20 ++-
>  fs/kernfs/kernfs-internal.h                   |   3 +
>  include/linux/kernfs.h                        |   1 +
>  .../selftests/cgroup/test_memcontrol.c        | 122 ++++++++++++++++++
>  5 files changed, 161 insertions(+), 6 deletions(-)
> 
> 
> base-commit: ba268514ea14b44570030e8ed2aef92a38679e85
> -- 
> 2.53.0.273.g2a3d683680-goog
> 

In future posts, please CC inotify patches to fsdevel and inotify maintainers.

Thanks,
Amir.

