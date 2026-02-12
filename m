Return-Path: <cgroups+bounces-13917-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJZVDl5FjmmfBQEAu9opvQ
	(envelope-from <cgroups+bounces-13917-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:25:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD01313E2
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF1B930ED882
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 21:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EF7345CC9;
	Thu, 12 Feb 2026 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfGm4oPC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530CA32D7F7
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931531; cv=none; b=Ti8x3KndIO/XAFBID8z4EJsCpcG7CB6Dl5tHimT68LgYeAy9bt8jMC7CrY3mQL7RdI00UVJ4KmzBK/pzHHP+TGyLCvyx9HlAZxGXdkQoDtd7j2F6y6lX4rEc2XCk+L/ZJYwYJcDfVzJJ7F/whfPqabF2/SpbJpLW798YU4GYbcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931531; c=relaxed/simple;
	bh=4VOKf0xEU2BdqyQq8g7jnYrqEcpcWaBqoYKpXVHd/0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erRjkU3LuLb5Pp62U+cNz+6nJV+GXUv57nTb4JJDX+ll7UHDlm8NdVmxrTzVwqEKIHRzjDlUMAGeLKIgBN/vsQ6uUNlc+12dH1T7Xw6sKf3Vib787O1HUGqz9KYW6Sf7HGFoqMHSJ9o9pKalTiKbWUfvdbUB+Pk0+AEa73evwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfGm4oPC; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2ba94dbf739so335439eec.1
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 13:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770931529; x=1771536329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCh0D1PgFCAnFv/ObCs8wiM+Hp+1ve3byqWcWmOrNFg=;
        b=TfGm4oPCraS7qYkj0oMlo5ClFTiXNU7zFYJqg6K25lKKfwNx4Mf0sVKc1qpLapH3v3
         iS9CkbCthQZXOsdqJGUfZNZWv0ygM2G94LTBuHhwyl74Xzs7S7/z674qFezw8lGVh0Sx
         3m52Hd5f0DuVr+4RE+JylZyHDOwpjJSjh7iG0Wew180LvOcnYUyc/BeIVswsruGN6tc5
         lv2W9hYdoB0cUGPqLV+2AYO3CdvTOMaxPW5EVnAzqF9pUnh5a/xgC4XK+e9AW44E2u+s
         kxiE7UYhKH2t1aseUJPKKw608Dw53yfvQzWqR8vJweVqiglae19ukWUKY/FvcsEJj28x
         hZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931529; x=1771536329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCh0D1PgFCAnFv/ObCs8wiM+Hp+1ve3byqWcWmOrNFg=;
        b=sJP6YeHu1wZ/ZAYR7y3mYGfugZ7hxeC2kLcB/knefcJ9NWTbiHUqvIyqN3suTjr/EQ
         q7qlDp6tc6VtJTYwIig8dwno4+RLZJwXZRy9ROV9oDKkAJS7vYhygFwR52Y1sPxXWZcI
         fv2llxQB9Z7FXIoJiHpnGBZNOddopN8TZ2VmLGmzPIvLHhxGSvb6zmBbueQ1IaQqRrar
         82Y0MUNl4MWT9RDh7P3WK3imiM1+EFjEBdIZrLjhBrdAvw9GtHZLYriE0gQRhLUUb5L5
         +mW3Xm/xmRWK62Ocm8zYYFKTMeeyq8LosNJDhTVh2USiFgcOgr2ufi4+sHK4XORvJSbJ
         qKcA==
X-Forwarded-Encrypted: i=1; AJvYcCVVFULMvhZz/wakDOLRAGgBa4/FamgAle8Xiudozz4GAPbJoP4nrSe8nbgGH1NLS3KYBTA5g1K7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzqulhn/phUHgzFNT+qF+HkWGIoHkHkmCc9VaXuG9GJw/yx+G1
	yVH/QPtHxiWW8Rm5zvqMQ3HhLoOb89EKErbYXh6IrZK97908RlC5Dquc
X-Gm-Gg: AZuq6aIr2hW20m4dviiFfRqtj5H4o71SswJCsX7IzcDIR6bptK9IdjAO1svrimtPdgR
	bAbrIUnMxzm52B6ww/9Bev55PiTBsWpxF2kpoSY/2Lll5qJKNFAIw68SCfFpwTVrfeUs4YSoP9t
	HqZnsUqgGBO6k2Zz5BjqexUBcMhS1gXkhPBrE5lSLdaew9wXc9MDZXRXirsdoiMJlnAp4/WTw76
	RBgIAwGY8DkQelaS+3Ln/ANsBxj97mmYsx2reXQMTKK92OJxKOG0b8xawWtFSMUalxMjFOuROKd
	+tw8fHzoZBASXP+h7XZNnDShTGV4PKYihQxMuBTgDbR419D7fIhzfuk6eRKBrPOE61WZeuEf+q9
	nF4WErFus9w8r1/aTr18e3pN/S25n6dcDdQjtx/o70TEtoBk3j4iruz7KChYYPZzGeN7lfIpkMJ
	pqux+yAOkcB1k/VQ3W6K8/6ivAJQiBik6K
X-Received: by 2002:a05:7301:7c12:b0:2b7:f44a:a6ad with SMTP id 5a478bee46e88-2baba136a9cmr114756eec.42.1770931529389;
        Thu, 12 Feb 2026 13:25:29 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd0614sm4779914eec.22.2026.02.12.13.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 13:25:28 -0800 (PST)
Message-ID: <b5927ae8-3108-4d65-bee9-be306fb697b4@gmail.com>
Date: Thu, 12 Feb 2026 13:25:26 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
To: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc: apopple@nvidia.com, akpm@linux-foundation.org, axelrasmussen@google.com,
 byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
 eperezma@redhat.com, gourry@gourry.net, jasowang@redhat.com,
 hannes@cmpxchg.org, joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, mst@redhat.com, mhocko@suse.com, rppt@kernel.org,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com, rakie.kim@sk.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
 virtualization@lists.linux.dev, weixugc@google.com,
 xuanzhuo@linux.alibaba.com, ying.huang@linux.alibaba.com,
 yuanchu@google.com, ziy@nvidia.com, kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com>
 <96b63efb-551f-4dd5-b4a2-ac67da577431@suse.cz>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <96b63efb-551f-4dd5-b4a2-ac67da577431@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13917-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,suse.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93CD01313E2
X-Rspamd-Action: no action

On 2/12/26 7:24 AM, Vlastimil Babka wrote:
> On 2/12/26 05:51, JP Kobryn wrote:
>> It would be useful to see a breakdown of allocations to understand which
>> NUMA policies are driving them. For example, when investigating memory
>> pressure, having policy-specific counts could show that allocations were
>> bound to the affected node (via MPOL_BIND).
>>
>> Add per-policy page allocation counters as new node stat items. These
>> counters can provide correlation between a mempolicy and pressure on a
>> given node.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Are the numa_{hit,miss,etc.} counters insufficient? Could they be extended
> in a way that would capture any missing important details? A counter per
> policy type seems exhaustive, but then on one hand it might be not important
> to distinguish beetween some of them, and on the other hand it doesn't track
> the nodemask anyway.

The two patches of the series should complement each other. When
investigating memory pressure, we could identify the affected nodes
(patch 2). Then we can cross-reference the policy-specific stats to find
any correlation (this patch).

I think extending numa_* counters would call for more permutations to
account for the numa stat per policy. I think distinguishing between
MPOL_DEFAULT and MPOL_BIND is meaningful, for example. Am I
understanding your question?

