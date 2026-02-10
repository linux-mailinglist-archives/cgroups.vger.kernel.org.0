Return-Path: <cgroups+bounces-13843-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NWuF8WFi2neVAAAu9opvQ
	(envelope-from <cgroups+bounces-13843-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 20:23:49 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC89611E9E7
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 20:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 947B0301D304
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 19:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0DB38F245;
	Tue, 10 Feb 2026 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6lA8u5V"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D82DECC5
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770751422; cv=pass; b=h3Ht4Iv7aiTR4p4s9gMP6SsvwvRvH1j3jC1jtOTdxX7cbVhxY3l25EOnzuuroh40g4/y0eUYz2zkcBN1ElIz61TiBEARWYvtWOzx0QXWlSjBxE80i/AVes3ebeb1prMfBEHrXx/RNZ/vzZ0QpPinXGrB/pOwe/cjFPUhanqJTIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770751422; c=relaxed/simple;
	bh=pBYVGOJgAAh0wUGtGHCzoyofcM36bp9tfn4+54TVIks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=insVxQLhIluJjhOfqNZ5h/2nWleLUFLypMMJJH6Q8GCV9H0RG+9mWssOroRWdWfPdNSA4h1n6/LFrpYW7BsnGwApjepZwIu63zQDxqPpJLj3L/E09qVThESFaMIFfx9SF8TfLT1tUc8rkwkzgRfui0W/cUMjUigsRE7ANZ2ross=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6lA8u5V; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so1711795e9.0
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 11:23:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770751419; cv=none;
        d=google.com; s=arc-20240605;
        b=Anm+E7hgfvfKOF/TWER6OudfYewxkQ9W+mme38jghk/YO93lYx9k5SSEDvXh4+yerV
         ou3oNgAZ+H9BNdwBwS7MWtaeQFeTSsFsBlIjx8QBmR0BKeZGCulm3Z9q8MfYm3a7ZdGy
         TvkJgHM9Eu0swqrGqUpKfTmgZF5CbfGCzcmuz5tb8GmrdIeVyflrw1rZ451vtgaCGWAb
         K1gXQNSNRTbiDcJBFxKiX5PGqPczNV95KkL9SFS8UlEil0p8nWFgHScCD8TjEOPt2bIH
         f2da1x6NSxo0tlE91i+UlOkyGmpWxExyF0yYpZyYyy/GjkeUQEbk0MYfKtKxOp+i/Jul
         5/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pBYVGOJgAAh0wUGtGHCzoyofcM36bp9tfn4+54TVIks=;
        fh=02A6zIjo2dH2SFaSnZYnsBa3kNholYOk21l46Mop6aI=;
        b=gdCKFSIpT8jgsDMDSGb+fAfkfohrtqQRdiOQzZNGvJ6QkgjlsqFTZWhl64XJ2Kz62/
         +/t1fGSaQoeB9Xm155vK7QszS5twPGhwumEweSR0Z/YV8uqlBPAeB4I7It1XNVKBc2wK
         h73v8lkH0Km7Acvc2DCC/ACS44orP7ZgZNptOPN0JoqmS4cPV6hwU5U4d0rKRC0qhh3U
         p5XAHOG4ghn8O4wcam1RdShqsFNQraBMo+97SN5iA7ZdGsDC9kn9kzSPnB18z1FSrIU6
         Qgh7Yi8qvWhx2IbP/vdfC45vP+XDKCz0xqEMVWaNTzrZVf2o4xMxnHcDwm+cSOgvue24
         axOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770751419; x=1771356219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBYVGOJgAAh0wUGtGHCzoyofcM36bp9tfn4+54TVIks=;
        b=S6lA8u5V+xZ2ut4fSKTSKkBPBf07tiJv+F20Kb3OWHYofk92XZcJ4aJP6mda1lzfL4
         nVt/O1lL4la3TC9a6N6QM3BcOcvBY6fRvsDl7IUwo6okJvL9gx0S3QVfxzTuKJ3OWTGV
         JoWj553UZsJ62PxWrejzR2cXZfiv1tjYPhDdiyTrKPaBZDn5h5UHoGeNFy+3wvZ+BAFf
         2EtNHEyK1YiFbF74zpI97mFdtyPdrjVGqV6l5SGQBce+J7sz873twsyOekm4ssIynAxN
         YN2Rmxnk4DzR0AgQNFv9WRaFFMHI6mJnez4EP2mAXDC10l6XiJFGjn0mr/hKua1o67bo
         PVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770751419; x=1771356219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBYVGOJgAAh0wUGtGHCzoyofcM36bp9tfn4+54TVIks=;
        b=ZWcQfAvUOOn1CavxZuQ2xuxFChPL4NabIqh2Pnx7aR5A8gism1LhPqchF21noyf68d
         vpYjWSfPcyn1L8qMS08qNoDHYOR+0H5r5GFiFpBXS07kttJibA70dtDTIdzc2x2pECm6
         NY8/LGxqzys6Uv3EwxtXK4gExq68k4xGbuCb1JHm2gkikvxkRwfg85JnSS4bIyvlBNjG
         fdkdAMH9bBcPDNVskS3fs3pULpa9+e+aQyiucjLs4sMUiuSj9R2i4leD84lhNdprg8QP
         UA+D2TPMSWjUVDJo7AeTZ5TZX6PXVEY+w95cUXCjC3KhUxinyGcrjK35aMJlX8fq1iPW
         mwwA==
X-Forwarded-Encrypted: i=1; AJvYcCVqGUBH+rFW61QJkaQCX8bXHegij+oXvxdhQCazM5xF97IbmJ+8RZVFdnQQtlxgo+0TdcQ0MzK2@vger.kernel.org
X-Gm-Message-State: AOJu0YzIOUO4SoTrRxcSXFxNPzNm0tLoafz3BjkmgZm/fTwGDysJuHR3
	eEJ3oXzp1gwwA2v3JFxjZIDIa/SWsGRAK1NbaX4A5GJHG+edYLviwdPK/8xLkmu4I0P+z4bwTKe
	vREudFFGHo3q8JJ1+kGBoylsJPOYUzfA=
X-Gm-Gg: AZuq6aImPQCUIylFaSQcbW7GpQHMcY19rOHoaxPP5ZG2ejA7V7I5GQ7ZK30yWp5HTEJ
	bvEiqPVnGpZEDYRjh+QfOB4hJMj6ZB18j17r4OSoGwZOXZnqTwE562EPZK11Pd+G3Cxomu6Y4ox
	D0NJhGPYhVZJ5cmqiFpuSETUkYT5m8Q47hXbNnUkzYszh+Ovr8HcySe9FWARaj3Cu/QWe/BpydM
	HezaPQnZOlPJ6hCUrej6wZD1Y5vmIigzqxLxj4iouTCN0mCx7byrNKi12ErKhJ8+gdwti5V2gzo
	QFql984EU3PcJtkmx+MG5Vf0vOimMDZjHytsC58=
X-Received: by 2002:a05:600c:5288:b0:483:14ec:5925 with SMTP id
 5b1f17b1804b1-4835022927amr50988035e9.2.1770751419161; Tue, 10 Feb 2026
 11:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-2-nphamcs@gmail.com> <20260208222652.328284-1-nphamcs@gmail.com>
 <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com> <CAKEwX=OUni7PuUqGQUhbMDtErurFN_i=1RgzyQsNXy4LABhXoA@mail.gmail.com>
In-Reply-To: <CAKEwX=OUni7PuUqGQUhbMDtErurFN_i=1RgzyQsNXy4LABhXoA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 10 Feb 2026 11:23:27 -0800
X-Gm-Features: AZwV_QhDHop3xuaKmlrjyEY_sdgVS3677YBZxGUueqqiU-9ugNQbef3e4wRWWfo
Message-ID: <CAKEwX=OYauRgQoj7cxznpROknHt9NsKLOmkvaFtkEh8T1KASag@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, shikemeng@huaweicloud.com, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, bhe@redhat.com, osalvador@suse.de, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com, 
	joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	rafael@kernel.org, jannh@google.com, pfalcato@suse.de, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13843-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EC89611E9E7
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:11=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>>
> Hmm this one I don't think I can reproduce without your laptop ;)
>
> Jokes aside, I did try to run the kernel build with disk swapping, and
> the performance is on par with baseline. Swap performance with NVME
> swap tends to be dominated by IO work in my experiments. Do you think
> I missed something here? Maybe it's the concurrency difference (since
> I always run with -j$(nproc), i.e the number of workers =3D=3D the number
> of processors).

Ah I just noticed that your numbers include only systime. Ignore my IO
comments then.

(I still think in real production system, with disk swapping enabled,
then IO wait time is going to be really important. If you're going to
use disk swap, then this affects real time just as much if not more
than kernel CPU overhead).

