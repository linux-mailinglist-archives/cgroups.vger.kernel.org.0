Return-Path: <cgroups+bounces-12618-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E87BCDAB0B
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 22:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A31E73023576
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 21:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7D1311977;
	Tue, 23 Dec 2025 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lf7pE9vq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1602D248C
	for <cgroups@vger.kernel.org>; Tue, 23 Dec 2025 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766525896; cv=none; b=jU7HbYnOml9wn/V3sOCavYfaPfyAhXvipKjLGlIymBDDZ6htBi8DZ53OXd3G6XFZbVyFTh+LPuR0DxCFrb5r6b3uKCJ+FIqpjVbkiXp7zHZkyZPddZitoggOPPa8mtAmpuy7YRUfAmljiWjz+2QGbqCO9SwELrY7ejpf2waGZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766525896; c=relaxed/simple;
	bh=amwXhTHKhHkM5qG5ELiPfPDfhhboRVlZDHUCMMpLDNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2ie0kX/OUTM7AzOPA/+PhP+hgQv17l9NcPfRi2q1+Xw/8fb7Jew6t+AdmYWiqdowd0VjBjFzFthlIx441dtY/ufk+USsEvgQO8VMw5AxhigvIYSq0fW5pqhEbOlZSqwyRA3/KoALmBN7he6rx7ZU8ljgUWLnGktfMFXMi6PiuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lf7pE9vq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29e0753e5d8so777595ad.1
        for <cgroups@vger.kernel.org>; Tue, 23 Dec 2025 13:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766525894; x=1767130694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4UlY53rg0qpE7qUCOTeby0OH8dUG8TIZCeZtME6Mjs=;
        b=Lf7pE9vqR/a6xyx0To2Nui+2uKK5p/Xf3AbTfDseoAFC10OGaq1YmBHMmpp3p+NGeJ
         pXcuaTAkEwl6mrN2rVkYfRa9Z6witAXuxR4Fs/P32Ddnr2HDkl8xmFNP6KhKqPcGMZDi
         KIkhw+zOIjcLszVTCDBiXSQQshEO+J2qa3XoADtZLqrSogQdQYLCniK8yOinR+TPFxpG
         p1hCBXfamuEjnt1k1FmNY4ZR3t/Ot0DlYbr41WJLO7XDEbuXpihE1eO5xoN/3OeFdJNx
         8jtyduSrL4DMyXWQJ6PR0xbwITKBO7S8gDdcfPBGJBauhpDop+U566DE7vVjV3nAhMkK
         SUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766525894; x=1767130694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4UlY53rg0qpE7qUCOTeby0OH8dUG8TIZCeZtME6Mjs=;
        b=Ufq/nuiHhNuJAlRTX8z9yM4Brf15XdN5AW+DZ92ceyErPudA/ggdOl7cAm2nyi1JtD
         e0yWR0r5vZCuJu/8PMPsVpnfQe1GcjLD0cBEZhD9DMUa0vOnyY0e+NP91g/5RaJN4iqp
         EFIbTfmkZNr7uZecIu0daaXiBWcoQnr+P/xR2SqHsQJLo0WhjS71L8NSu34WJ5FfO0Oj
         m97812pFpgS+OjGXScHl564eD8EDGxKpRQyG+7Rdhhc1kjcIDOEcK5MBIUeRAAExBEA5
         5iD2xOSt9Y+MHZHr3mAsgnjcJezfuojmdQrwWBvfkJB/xBEtGW9lBAS1MdQv14opActx
         CQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYk3N4tBNhdE9+txgJa+XcBiqvsj59wJ4AmlcnsDgPQsFbYcPlUz4jUM8s2GUR0BRFD7feETFF@vger.kernel.org
X-Gm-Message-State: AOJu0YzoaHreP4IoS0pI4nm2veI6Iah8Z9+SE2i50gR7LRZ7Dp2ZP3MT
	dgqpkWLP1fQQU3SNG+ThELJ+Z9+ZQaMp7NX8raBT3ZexopKCGGnpagUf35WGZb8SMg==
X-Gm-Gg: AY/fxX60EgtTuFWvZ4Qo3bPd1nGAz7ozFcg3uyrM/ZyZbb82QPzEmqq05u4N5AWgKoN
	7Tv3Jw/v8MTO7MeR1pGJ/2xg6UUzm/FYMcxNNgEwxi2Gpzs4ZNt6J5SR1W8Pl4SJUrzhBdmwDgr
	WoCzILBpCUVL7tEyperd0yXoYnzK84gQerjSbQlFlKXCUUjJfNEPXuzdsOXpVCLAc0aHt1JBhtN
	fNJSXXfQcsxUP3yAC5CAN7sLwkCRA+wnlT/77cs1Z3bT9nAMtVfS/Ho+jJ8lfOCP9qUhjZd4cyM
	fAZB36rrz9WeYcmdoGJOCEfAnOSp2Dhv0cFb8UkycahT1EASdLykwGbZZWY0vQWdeKBFRuIGypy
	MMxzTPCM+Wo+1wNaw/q+iFEwSW2PNo5a6LZWBM9YL53bhm8Rh05oYYZgqkaniQlCBacvMubbCf4
	1487no62LIjqMmRnJvDTHvE4J63/jN9EjU69YHk0RTRRNh3xrbI9h9
X-Google-Smtp-Source: AGHT+IGs52EWQM2FUMzO5YyNfnbgcTLrszUf1ftByMtYiGKp+ZRXjSGr4Y7SBZ44TSjuWIdc+/wPVg==
X-Received: by 2002:a17:903:380e:b0:2a0:89b0:71d7 with SMTP id d9443c01a7336-2a353a52bf9mr268415ad.13.1766525893282;
        Tue, 23 Dec 2025 13:38:13 -0800 (PST)
Received: from google.com (248.132.125.34.bc.googleusercontent.com. [34.125.132.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66465sm137827105ad.15.2025.12.23.13.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 13:38:12 -0800 (PST)
Date: Tue, 23 Dec 2025 21:38:07 +0000
From: Bing Jiao <bingjiao@google.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	gourry@gourry.net, longman@redhat.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com,
	chenridong@huaweicloud.com, yuanchu@google.com, weixugc@google.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-ID: <aUsLv7LAgqGlhTjW@google.com>
References: <20251221233635.3761887-1-bingjiao@google.com>
 <20251223212032.665731-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223212032.665731-1-bingjiao@google.com>

On Tue, Dec 23, 2025 at 09:19:59PM +0000, Bing Jiao wrote:
> Fix two bugs in demote_folio_list() and can_demote() due to incorrect
> demotion target checks in reclaim/demotion.
>

Considering these bugs are introduced from one commit, I think
it is better to fix it in one patch rather than split it.

v3: Rename cpuset_node_allowed() as cpuset_node_get_allowed() to
    return effective_mems directly, providing better versatility
    (thanks Ridong for the suggestion).


