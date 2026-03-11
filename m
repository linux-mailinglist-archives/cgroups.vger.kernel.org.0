Return-Path: <cgroups+bounces-14773-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGsUH7XIsWnvFAAAu9opvQ
	(envelope-from <cgroups+bounces-14773-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 20:55:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC29269B44
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 20:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05EAF303FBD4
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 19:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8032D336ED1;
	Wed, 11 Mar 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QChZvknT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B12DEA62
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258861; cv=none; b=pXc/oNiLJVrlphy9tBrnxPeq2vsey7nRzJk90Ie35GW3rx7bVK1Wxfst1wC1T+PDP93Fzxe1q1Kn2wqTOSG0JBpxXug7BPk69oifQ17VWQpRAIX66TVwIXmayrogwl1MZPCqNCXKWhTWC9dDD/Du2QS8r7BTlt1XiCg0qJAlBCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258861; c=relaxed/simple;
	bh=a+uov2RhM+24JZ90DFn86AtDGVcGNH0iJdS15dHWP0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDr2tkdN1wNCpQyo3RsWWV9UJPMwVWexu9qe8zdCB2iXuY2HYI9J+X4WkoXj8Q/hzBCLi3ojlISBIcsWi56LnDOguPqWAAPH4zEeNQny8M+rMyEuH50wL8z4x+yZizIuD7QSII7Fq398uBhZWFK81c2QyX/zyDTcZrnbEogBCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QChZvknT; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d4c383f2fcso273441a34.0
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 12:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258859; x=1773863659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZZdNzPCNOWhzDGpoOJRtUQiGAcliYP4S9jnnNW7ciA=;
        b=QChZvknTplYwWcUNmH/cQAMdWtR1hJEv7H5rU4k9IjGrzrjMc1Ti0MUzVmy8kxHZ0y
         ERpN3WuHT5mIo27Jp0OVfC6xjzqVNrSOG1pgsxO5P+MmbDEwJbhQfCr7V4CB3/PJq1ug
         g9yFTKttOD3b5ETZ96vxZGteVelVDXZNMuKnqktGBofnNrjaR2zt8nVEQvH4+mmMtUv4
         bYqB+w43TlHT7B6vkq0mDKa2NNxZZ4KNv3lcDVtKMiecaCFyfz3w4U5AftozNR/xw4+9
         8SJcEs3j2Kw8YDdGk1cNMujbfiifJnXVQp9lnjaD9Iw6rub1QE2DgUGng4/O0PNOElzQ
         nNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258859; x=1773863659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ZZdNzPCNOWhzDGpoOJRtUQiGAcliYP4S9jnnNW7ciA=;
        b=pxuR1GRiDY3jSVRYrg37GSalqWdwp0V+CMv7Kq3zyuuaAayfaCJaBw5kz3xN4eAE1T
         ehPlsQL9It07OhRzG/8iHo2oQ+zddSbs9EXQdFdrG6EAQX+smmtdwGUIfVxLYn3Wx3B6
         J8xpBWvzYmv3OHLaDeYYrO94zQITmkLCJQi8JKHiV5wi0OB7yWXhIZfMH+o7PgVXU+XQ
         kNkJ3OSldBdGHXBigGpe/8r7RfT/2WywzR6NSetVbTg4wuzSOBYxGYpW49WIGb4ZdiDZ
         /mhxuBsgZgqVzeg/wDLt1NXo3Z9/gxn97wYwovOpykmNOTYz2To115tGubxfrAJKsmwC
         9rKA==
X-Forwarded-Encrypted: i=1; AJvYcCXXZLC+cGvS1w1nAJ7U8XCZlId9YXz4t6FbJZfSm6L1/B+cma2IDNnSDHVgqG9MR5oYtGr3wLn3@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6wyjhEhO8tauckV2nCsikjYW6Gs+c5odgOqMyM7bi/E5h7er
	w7xelWHC6kqqWxxlkf1rNq3MjrNOApK5bGCqa+3OybPQ2PLh+OFB+daV
X-Gm-Gg: ATEYQzxPF9TQUk7uiOZOZRTTSVV1OnSYaOw2f5tKw+d46n1fNz/aqlL8KM4jieauB11
	MHDBHekTZTkZFkQ9jA/jsDwwKTERSxwkl7Zb71cKHTzDml5NITE8vH9EZ2+Mh6x1Nw3UyrBHQ/s
	ZXPZEGRDl3jGre9XVqi65zjXmx4Y7jXHWdeEp4++h3RzYxLKVZVe4SJcqw8fqH3WUIRaUTBgOUg
	KQ4/vS3ED8HmND1S66pYO5XWccvyMOnDfWhg0WKlbfWcaa0dfWTjTsvHLaCrPslmBlD5k3JAjb0
	rrV170YHwvktwNUOrF2C9BTEbkAWGQauNRzsbORXHH7RR2FyIpbI/Bo6+BdNOlFEf18nTST8vyE
	LFmoBqIQRL2aVgs/5WGFMYy0XiAlOBxMqIe21xyojkYb1sUO1s4fRNXZ6lZ8yE5aeTmPzs4cxaE
	SIdYbZ5u8CDetY7M+szkEzlA==
X-Received: by 2002:a05:6830:dc9:b0:7d7:5d66:4709 with SMTP id 46e09a7af769-7d76a7a4e59mr2686812a34.14.1773258858976;
        Wed, 11 Mar 2026 12:54:18 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae68a4bsm2489578a34.19.2026.03.11.12.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:54:18 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 00/11] mm/zswap, zsmalloc: Per-memcg-lruvec zswap accounting
Date: Wed, 11 Mar 2026 12:54:16 -0700
Message-ID: <20260311195416.4050026-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-14773-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,chromium.org,cmpxchg.org,linux.dev,gmail.com,oracle.com,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FC29269B44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 12:51:37 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

Ouch, immediately after sending these out I realized that I forgot to
add a "V2" indicator in the subjects of all of these patches.

I apologize for the noise.

> Joshua Hahn (11):
>   mm/zsmalloc: Rename zs_object_copy to zs_obj_copy
>   mm/zsmalloc: Make all obj_idx unsigned ints
>   mm/zsmalloc: Introduce conditional memcg awareness to zs_pool
>   mm/zsmalloc: Introduce objcgs pointer in struct zspage
>   mm/zsmalloc: Store obj_cgroup pointer in zspage
>   mm/zsmalloc, zswap: Redirect zswap_entry->objcg to zspage
>   mm/zsmalloc, zswap: Handle objcg charging and lifetime in zsmalloc
>   mm/memcontrol: Track MEMCG_ZSWAPPED in bytes
>   mm/vmstat, memcontrol: Track ZSWAP_B, ZSWAPPED_B per-memcg-lruvec
>   mm/zsmalloc: Handle single object charge migration in migrate_zspage
>   mm/zsmalloc: Handle charge migration in zpdesc substitution
> 
>  drivers/block/zram/zram_drv.c |  10 +-
>  include/linux/memcontrol.h    |  20 +-
>  include/linux/mmzone.h        |   2 +
>  include/linux/zsmalloc.h      |   9 +-
>  mm/memcontrol.c               |  75 ++-----
>  mm/vmstat.c                   |   2 +
>  mm/zsmalloc.c                 | 381 ++++++++++++++++++++++++++++++++--
>  mm/zswap.c                    |  66 +++---
>  8 files changed, 431 insertions(+), 134 deletions(-)
> 
> -- 
> 2.52.0

