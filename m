Return-Path: <cgroups+bounces-15023-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OJ/GxqSwmkXfAQAu9opvQ
	(envelope-from <cgroups+bounces-15023-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 14:31:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 780F230970C
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 14:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2A1A303ABD5
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A19E3EAC77;
	Tue, 24 Mar 2026 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZLBQI/n"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB873A453E
	for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358384; cv=none; b=madEqKW8O7zXSg48E+rCRqZqFYqwJZOgrZF9jmP6vY6W/IInuX9D/Ejd9gVratUUS7iGfsS4i3yKKu77TJAb777wuhIcKFAWRbdxEKxfMmZI6AoQbhwknL7VWpF02GwXfXTTI7Il1P2125Ij7XmPi4N0sb0Lv6hrGOARYzIg6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358384; c=relaxed/simple;
	bh=V9oMmKBuAy0HzNU9dHvJsrEVQ950oTkPENYiU9M38dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyA8ymlmdWHqEBEalFfKo7PsOQFIX/hT+a6rw+B+kE/6C9lc2AjDVtMuSsf2/rmfUISqNTXK3YjPZ3K6UOJpj1ekKdnw1T97julatQ4nYF2jlFg7bH5OuyA8S+8i5UVUeuMAHYJ9S5+QuwHI9pMN8EWDwsQG9tbjceDIePcGyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZLBQI/n; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48702d51cd0so38745065e9.2
        for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774358382; x=1774963182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDW9QxylvtudolC4OrULLL0I8iMCwV1m1od/FFAOgBU=;
        b=AZLBQI/n+B8UQ4z/PBbbRta7WCkJBhIqf3t/ICJs39g27m1N9Qrdtn6b1Ql6lHrDN9
         plFbuZcDzjwS3556cyOQBHeMrKSy9RpbOH3fvO0hsgy+iMAhnlJFHQgeGfiUwKz9MgeU
         rWoNt3C3hwxsyqGLHBb14NxaVWtCHUcqeNDe144p+yucaoAtspkoTpYAajWyt7FMIPxt
         2UklR6rODfMt/q/bNs84cmy6iSxqHQkoyEQrIvUuAHRUXwGzCHnxjsDsuN1FA1cJWPQ8
         Zvc7NjeF2RATIqk5C8e8snnd1qvtL/zhJZl9Ntlgr+0NmKmg0i9poPa7lttRZFB4vgNZ
         NQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774358382; x=1774963182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hDW9QxylvtudolC4OrULLL0I8iMCwV1m1od/FFAOgBU=;
        b=WRCz13nsiOiJvKz/4vYjp0cEc1+QROs2wvt4HT4TRGaHbsLOqNeteY5N5loX1O8x60
         e77mLzG1QSsNNh+aXN1nstFqNb/fBeSXCoNbb39ZKuX+ttQ2huf8jv0+m8hE4489ZMow
         omPtyloC7QEATUMb7GwysfdmQ/G3If/jjEB2HOjGSnYgBWCR1wg9MAigmQBkwFK6eI+C
         0QnNMIqn5LieU1mL+zul5opQZ9Z5Eu4un4b3WnW2ymWMoBU/LqL66+9cn4djNJuibURd
         1D8OXh80EGglEE/WdSOoA3zjtdIWXJGKY3LTMf7cCAiVvy6T1wfZeM+QfLx5SStZ0hef
         a78Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7XJEAndSIQcqV8/rrxQYVbRuuS8WUl19utRDzRWFOikjZCjF5/baPM9RmXbMD++xAYk9BfsuS@vger.kernel.org
X-Gm-Message-State: AOJu0YyvuWi19uSFIIH3ouNxUKJ94RNdrXRa05R+c44D/GEjyzVND2/v
	UOQsXhGdMUR8wuPpv458In9gwZUT9kb3/90M9QJ3SVy+UQHGnM4x3B46
X-Gm-Gg: ATEYQzwrTUl1D0whoW+e7gtP5kPtZtOJbKiWKyl8Fp//NJ9vAATSX8LAfwkywl+708s
	Fc6eupbrDhvNYkE/HnjD9o2zUNEhTmudcIa4x9CgUbhaJxpRoiI8oIvgdGnGCn8wnvNPY57U1QV
	xeePk+DePee+F0mJVPHb+T6KtMmV1xGLnfZrSsYhuoveL30wUAMyg5Wbl/SuC8h/ZnqXgQF9K5W
	ij3F44MnbxSpYcZeqJ28rcMJmVrbZc+Kchzyu8lgI3+OmwwfxF3DZMkxdF/zN5NiZt6P+x5QqCS
	YhoBHIJpNK1yoaKOeq8vG2HZY4f2yv9NCbO8K/jzTAWEjSYZ/J/bXo2RkporX7jS40m17XpjQXo
	VhDu0NbFRQ+BtnsEl/Xj9OfttiMbAUBbXYfDmJgnEeBJ5meOjPZ72RmRWybm8Wc2q2EoZowUOi2
	BrMWD3RaB1vXNkPCWh9QA=
X-Received: by 2002:a05:600c:1c16:b0:485:39d4:2dd9 with SMTP id 5b1f17b1804b1-486ff04fb4cmr260524475e9.33.1774358381485;
        Tue, 24 Mar 2026 06:19:41 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-487116939b8sm77926095e9.3.2026.03.24.06.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 06:19:40 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: nphamcs@gmail.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	kasong@tencent.com,
	kernel-team@meta.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	riel@surriel.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	Kairui Song <ryncsn@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
Date: Tue, 24 Mar 2026 16:19:31 +0300
Message-ID: <20260324131931.4004123-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320192735.748051-1-nphamcs@gmail.com>
References: <20260320192735.748051-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15023-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,tencent.com,meta.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,surriel.com,huaweicloud.com,suse.cz,bytedance.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[56];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 780F230970C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nhat Pham <nphamcs@gmail.com>:
> We can even perform compressed writeback
> (i.e writing these pages without decompressing them) (see [12]).

> [12]: https://lore.kernel.org/linux-mm/ZeZSDLWwDed0CgT3@casper.infradead.org/

This is supported in zram. The support was added here:
https://lore.kernel.org/all/20251201094754.4149975-1-senozhatsky@chromium.org/ .
It is already in mainline.

-- 
Askar Safin

