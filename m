Return-Path: <cgroups+bounces-15107-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ii+OHWGymn09gUAu9opvQ
	(envelope-from <cgroups+bounces-15107-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 16:19:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3D935CB44
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 16:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B779307C264
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 14:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C7F3BED7B;
	Mon, 30 Mar 2026 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZupGTnj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66943C276D
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879815; cv=none; b=UwC6PSdIKu9kyunjJ2cCXeW6JYeK7DOo73FBA/sr//sesXmK58DDFqeoIsHKxRQH9l5eZLQLfK1idLwItCX5InlqYo070XO0NcRNDTRTU+AebzW9s7eicRYCZF0AkPP7j+hLzrcGDcFozK2KfoEuyj1beGbnLKLGgpg45aT1KJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879815; c=relaxed/simple;
	bh=X00iyPLUf/MpgfrLqE3IToB+I0uP/6U1vsaQL+fdMys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFrXfHeM50x1oNwVuj8SA2rk2ylyIe1kroiEs9GRvEqalpucJvL0MHx5yL1mV8HIe6YEUOzs9H+SjA+ToVkDasEBchNv8Vi+aTwdSoxAImcELcM/pe7Q9z9TmJY7DhEnu9BUAHIYP328hBxHDii+qLakdvoEX40qa74Jzft8XcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZupGTnj; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40429b1d8baso1712896fac.0
        for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774879813; x=1775484613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xL8uHHzuWMbBwJ5+3HtVtL72FNsO/9cgkReiuuiZMA=;
        b=oZupGTnj4fgdCSUDtq1ZZfq2TTfJxcVfwZjAI+/YjzKVQiE+T6Fta4vVNVEY4ExofD
         7M+vkwxyUjHHpUYAP0Ex2cZ3OCaSf8OLIv9eH4y4IM8aYdka5KrDb4OWt38qJqSRkAQ0
         QvzJLg6XZnVXQB3V9pKkv1yfvv6Zt60ugVTJE0nsCQNf4FVUXsUxsF7u8sHUGHZDOqP9
         S4MVO/eJphA+PwluE8Ay+5+sJZUV9HEseQCmzEoRtFgWxbNjUTkyH1+8FK+kBVxCevIw
         wlxLLKc8bFp2UNL4TZ+hmtv9D0/GTobE7P7k9ltXq9WJPTdkX56ZX2KCvDSRv0uto4JX
         mAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774879813; x=1775484613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/xL8uHHzuWMbBwJ5+3HtVtL72FNsO/9cgkReiuuiZMA=;
        b=WJZWWIh8WP7wLZMeTe6p/PdfK9fApMlFUn50czCKQDdqFGfbjwHUMvmu24jex6PGOt
         jMdKmp3aOcRt4KQxaZ1vvJKJQ5APs56oKYkwe8rlbuxTCoEtZc+DscicuZYlxklIMxLL
         ewolI3u7rcIi/NUUgBQuT5hL3WjI0OKugo46T9zVe+1Cjv+3tODe4OcJOZ43yjNnyGRi
         HrDuDESF9cCPxpoR2TdWAdD1zGKxrm73zcV0BdPvnap/l9ikYPENgYNRB1/K3UHhsc5+
         2Nv61HFHFDmv1pRPO2kxfKeYiurcyjO3+Vj7KRIu+U2LAmosYMfizE5uwSMC6/Wx+Msb
         5ApA==
X-Forwarded-Encrypted: i=1; AJvYcCW9Pqi3GSeJbOHqy8FZ2mb9UOwzW9PC4EVlOHL9R1WhG5Dg8M3XuyCsdreKzgAPh/YIIhD4gCGU@vger.kernel.org
X-Gm-Message-State: AOJu0YwV48b0VZ4o5UVvLhf4OH4O0qUzVtMdSq1CvtNfewHHSurM17Yo
	Ky80UAPR00iqY8LdT5J2YNA5iY719RBYhmnlA1aF+qiPkOByTcI5LydI+EPKVA==
X-Gm-Gg: ATEYQzyY8VMAgxz59PoioqHmjt1WlB+CHXXuEEjLCnbMPKpXyrdUkddEBMw3Aphh/wX
	viAipayXWQCjm1NFBnlBfX+ahR9HxhQAJlsNGJ1qrgzABjsXQbxLBELZEu5i44Yq8uePc6Fvhvc
	kEI6/P4nfZlDVqU2zw7WjQYFHPkqgw9ZUQ9FvfE62AHYb7PREdT4uXLGboSOJVI5BeJaOk9tKuH
	5CiLt3AiVHLuE4X0oMU0sMYnHsILxTXvzbSOe8YeIsPswJ77Q5l3MXskCL8XKiMYjJU90Ur/huZ
	lsRa7VqFrS0W9Z0id+AUhyvOhaU9d9Pme/xTcOKz5i1kH4mHhaSHTtjr/3Ue0sALiGw6Fqm/ep4
	mi3+7F6/LpOXk1s/Baq1yhbHAgljJwP4EL9uTpB6WGr+Aj10zfb6HrWAqtMd7d1ibX7k6PfzKec
	v/rlPygv28+rVHxy7JGscX
X-Received: by 2002:a05:6870:612c:b0:41b:e9c4:9778 with SMTP id 586e51a60fabf-41cec29a8eemr6470923fac.32.1774879812679;
        Mon, 30 Mar 2026 07:10:12 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d048e1961sm5508071fac.2.2026.03.30.07.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:10:12 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mm/percpu, memcontrol: Per-memcg-lruvec percpu accounting
Date: Mon, 30 Mar 2026 07:10:10 -0700
Message-ID: <20260330141010.3126996-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <acpmkY6_gWLdtJCB@tiehlicka>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15107-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D3D935CB44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 14:03:29 +0200 Michal Hocko <mhocko@suse.com> wrote:

> On Fri 27-03-26 12:19:35, Joshua Hahn wrote:
> > Convert MEMCG_PERCPU_B from a memcg_stat_item to a memcg_node_stat_item
> > to give visibility into per-node breakdowns for percpu allocations and
> > turn it into NR_PERCPU_B.
> 
> Why do we need/want this?

Hello Michal,

Thank you for reviewing my patch! I hope you are doing well.

You're right, I could have done a better job of motivating the patch.
My intent with this patch is to give some more visibility into where
memory is physically, once you know which memcg it is in.

Percpu memory could probably be seen as "trivial" when it comes to figuring
out what node it is on, but I'm hoping to make similar transitions to the
rest of enum memcg_stat_item as well (you can see my work for the zswap
stats in [1]).

When all of the memory is moved from being tracked per-memcg to per-lruvec,
then the final vision would be able to attribute node placement within
each memcg, which can help with diagnosing things like asymmetric node
pressure within a memcg, which is currently only partially accurate.

Getting per-node breakdowns of percpu memory orthogonal to memcgs also
seems like a win to me. While unlikely, I think that we can benefit from
some amount of visibility into whether percpu allocations are happening
equally across all CPUs.

What do you think? Thank you again, I hope you have a great day!
Joshua

[1] https://lore.kernel.org/all/20260311195153.4013476-1-joshua.hahnjy@gmail.com/

