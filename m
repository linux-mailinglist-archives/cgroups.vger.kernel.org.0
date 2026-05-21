Return-Path: <cgroups+bounces-16155-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLfVBAXtDmqwDAYAu9opvQ
	(envelope-from <cgroups+bounces-16155-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 13:31:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D37C5A40E1
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 13:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3880430AD239
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075BC3C0611;
	Thu, 21 May 2026 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjwPiVXI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73C3BED16
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362907; cv=none; b=mNdW6Fza/1XSpzO/hGMJ9+StB96ufnzj0f2x5ldtIYoFioy2+a9L4YX0ab6yau8is4JUZ6QuIAsP6IA+ey99D2M0wgghpfdgK6Ebq/Jd3hYwP4FuIdHvXF+Gjl7ZntSndjaXmunYXwBuISo+haiPnN/CD7vV7fao+y4tnZVo8EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362907; c=relaxed/simple;
	bh=crnxHJfYWDJRmDbz2xey9GHVdmqGXJEqSVWyMF5jw8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB6ga3kt0rMgvTegb0Z15FGI98cvmmELWDcvI2rgN6qvnDsBxuXhH6r+Na/SxUIg0/E8RbpfdvazgE+IXd6uxENtDiKizh4wTSBxGjuYA2itfpnMzeo5N5qEpvoJkCFjhtSE28PSQFGIilsk7PYckM9L607X7EzchLar6i3YYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjwPiVXI; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1357c851a48so6770940c88.1
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 04:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779362904; x=1779967704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOrMn42JIi4qVYWDtDVlJUx7fmd1ReUe1tYeo+4md7U=;
        b=FjwPiVXIeUvD0SdM0LNT6HukyJRVnBHWMzs8S+iQWWkWruvvsu+K64+bVVisF2+Q1D
         z4zSqvoXmTgIshZRNuG2gvtT/QtHC4dZno2xGTsQuf+bBdcrsNRJvtUXQr+mpcmUf24P
         9yDQJrTg0tma1x7lUn/SCOoy9+cZJ0qcUYCyMvEl1YBJTesFO36V7CDHH6ga2/tXwPpE
         6PXrDCXVIcQjYuGVwjeiJV6nHgsr4Y1kFf0YPrVA2kf+lN9YqxoG4BI+OvloNHMygU0o
         h06X4C0mYFmrIbbF6TiM4m7qSZlm6H0gz+Pj1xNOozacQCfrKzhdUOJTEmT9506vEfWN
         KzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779362904; x=1779967704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MOrMn42JIi4qVYWDtDVlJUx7fmd1ReUe1tYeo+4md7U=;
        b=RNjEmWwXZXTcXqbWPm0L1vb70qqEl5xBwX1u70xoniBp2k74SbRPQw5ZXqUMSf/9BZ
         ExOrj3KeDbPS/Y2HpcwDoYxztYNDxncHzfdRsTV5Z0huWJbKVZvQ0L9BzaqF0tUo6B6U
         IqRx4lbYHAxWoOHvM9Z9bmG7HCl39DMP0gDxzvBAGyymgm02yEN/zBt0/4qOgsYb7r1R
         aHdjuQelesDU6SLwVhtTTVCvxwIUGOzRa0r4359t0wjzk+YQO2ohumkVIlCONI4ALzFM
         ZvN/nLIxl+X5NjV478CQmuhWsI1c1JMrjUdq7nQ9y7QTVQYMk8iXy9LJy/QqN7FFTtcA
         7htg==
X-Gm-Message-State: AOJu0YwAx6cUnz4aXGdPoTciuTVt2WO+2NbPmNfSTrvEcZ3m1hwgdmFf
	wP5i6hdGfB4zFVw8WKKzh+UctmifNG/0RT8HglhNPCSxZYlbLWff2GKe
X-Gm-Gg: Acq92OFUFCvEflAzNRgZeDvbNQCM0mGC5en3jCaPv04G4Wio74Vh5IU8j/DkhbJHuro
	11M/3Rb/p0hTlSqeioUoe03u0/7AmuEmnGCyAK0AdlwVVUkz1sj1byIJ+yUOxSYu9vodx9nbcyO
	+nwKRwxQ3cl5XWppLlkXUdrwk826FMMtqQ+QdW3Qbkbf5FSM+aFBhZZeJs3sY/BaDSVIHbG+Fug
	W47WgBI5iwr/6SmSHDknctFfH56qU56cb315ENz41DNAM4uwGArVzm4LyoYX2uZkWXiQOXAv/RH
	6zP1XezmdTwU+D8Q/VRY51agA4XTMWWoIKP87vMwlII/z5xC0L1BRgWv6/i0j6M+7GR4fxGiAAc
	SbxKhsyVsG2RQW6MlvRMQJ9zj8ycCCe1iobXJgMocuFBXTRsv9zYOzg0Gq635HX6sgaobrVkWFS
	0JTS6Oui9oiXGS2KDjZXEnRxR1TU+x7C5dNWP1sWwu9g==
X-Received: by 2002:a05:7022:384b:b0:134:fea9:f106 with SMTP id a92af1059eb24-13632c34f37mr1180557c88.34.1779362904342;
        Thu, 21 May 2026 04:28:24 -0700 (PDT)
Received: from wujing.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13652ac2afasm27839c88.14.2026.05.21.04.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 04:28:24 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
To: dev@lankhorst.se
Cc: cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	mkoutny@suse.com,
	mripard@kernel.org,
	natalie.vock@gmx.de,
	tj@kernel.org
Subject: Re: [PATCH] cgroup/dmem: implement dmem.high soft limit and throttling
Date: Thu, 21 May 2026 19:28:19 +0800
Message-ID: <20260521112819.62182-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <63878874-39d2-43d5-9fc3-68addf9ebbdd@lankhorst.se>
References: <63878874-39d2-43d5-9fc3-68addf9ebbdd@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-16155-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,cmpxchg.org,suse.com,kernel.org,gmx.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7D37C5A40E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Maarten,

On Thu, May 21, 2026 at 09:45 AM Maarten Lankhorst wrote:
> It's the approach I'm more worried about. I believe that it's
> better if we punish exceeding their high limit by preferentially
> evicting those.
> 
> It would make eviction run in 3 passes on the affected cgroup tree:
> - Round 1: Clients above their 'high' limit
> - Round 2: Clients above their 'low/min' limits
> - Round 3: Clients at or below their 'low' limit

Thank you for this concrete suggestion. This 3-pass eviction model is 
exactly what's needed to make the dmem soft limit effective.

It addresses the core problem of providing a viable "recovery action" when 
the limit is reached. By integrating these thresholds directly into the 
TTM/dmem eviction weight calculation, we can achieve a more natural 
over-subscription model.

I will rework the series for v2 to incorporate this hierarchy-aware 
eviction logic.

Kind regards,
~Qiliang

