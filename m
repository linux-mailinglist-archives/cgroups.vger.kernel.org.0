Return-Path: <cgroups+bounces-13913-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBXhN4pEjmmPBQEAu9opvQ
	(envelope-from <cgroups+bounces-13913-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:22:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BFD131378
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB496301DFA1
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 21:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC067329C69;
	Thu, 12 Feb 2026 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2mTfXk8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808CA298CC9
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931333; cv=none; b=GX2ihJ3I/vP6rBjiNpalNR5uHeSPLgJquJJYAjoMSeJneJQs1FzGLXMgQY7MDQF9GV1Eu9+n/MP88Gqv4UdzwIAOxkj8fCF2fNSWfRwUW/NQCeCZ95oNHaMDYot5Co5R3lE1ih6aCFxFtp3ow2ZcBJwqRZfblGr3LwvSEDSUxhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931333; c=relaxed/simple;
	bh=tnKhqaHrt/YHjDCTUT88krYBL9XB89h2wRCDDULlcLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/IXPHB3PiXfbdGyzwMAC6n7VhgJ1pSgLkLzZcvrIuaVVdPkgVDon/WOosRUBGMyx65Ni3irkKObsuVIO7FRUk4VPEEkKOuDW4ooakXIMD6cyouOqNQ8ej8Jwt4gP1qQcSBM2yW1O3164CU/QsiZPuzBr+9qGmh0BkN+KDLeUUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2mTfXk8; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1270be4d125so562400c88.1
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 13:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770931332; x=1771536132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1no2tHnWUokc2knFQltcsvUs2YRSdVUtSLFMCjUwtQ=;
        b=e2mTfXk8vQyQ2VTOL/2/AWqNW1vVlzxjKwD2xatG7x0xmNEarL/AF4aV/0jPSseObT
         mKlKp7CkAZWC+gQeSC3nrZHGRtSVcJMNs9IA8ogjE8uHSbFRUP9BkqpqZQ3x7baq/HKA
         tct8oEd/lxbaRaVdL1f0zhHTYNiPxR+XN/PRBHQ6AYK0PwAi/6ztOCSaBcFGDePhAR0L
         60ma85OPPERGC+umYWGS4ofFqXrR6wyQz5AC83Xc4235RargbPRbeif6brdTLRtiqcpn
         Q6yUJ5ca294OSKMk9jgpKs0C0jNYwpT8bF02ofLxQJhq9zBCl4gkWVXw77iaUhLuqI/S
         Llng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931332; x=1771536132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1no2tHnWUokc2knFQltcsvUs2YRSdVUtSLFMCjUwtQ=;
        b=pMHNYvd8DkbBvh9X30kBREdbBK6xiK7DbbrhhaJhBinwioNx7edEDb4waRmEISI8zX
         7lcV2Qc9Yz5tBVKuBHTGNAJhL3mStXLY9B4oHO5XNhZb0imYKefXr6hy5DyzaN6pKwIT
         dcr5qAdQ97rIq2ZbwxYPtBCP367wzVAJfCgtDOoAfZaJC2P7BsIoRS034zLlPJ1TBkdk
         Unmm42AYXxoARPaHvGwa2AEWvzHvP3gWm1hySeGBIOyEaVmYgm5R3+Pp8SvtL63q5/Qp
         TZdZuL2BEcMVJd3cDYo2zMCTpLIS2MBB0qE4vrwHjxhjgo8mz6+t6b/+tsr0wARtNmiH
         +xxw==
X-Forwarded-Encrypted: i=1; AJvYcCVhnIbW1QrZUSWNwz7ZDmEiXdqvLDlQjSxfCXPfnB2luQx3Hke1v3bwdSmNv+ftyhNShb9Z4/XN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1EtINHzI5iNZcmwEKTHLlHSN4QmRoZf14paLfPxhhtBO0BRu
	AsQUzbPZ6+ZNf/rpM/N+9uNUfwv568Z6G4gCUNb9uhWy2EQJyjL2Y3oS
X-Gm-Gg: AZuq6aK58OtxSIWIQSsyK+IQPbLSa8p5taaxPah9Ikta8/lsDrU/Gi+q6uQygRNdk6t
	X8C7s0l9jMa/D5bONGmosFq/kByshY1/r0L0b2GIYqBs96Xk8R1pruwBpoEOnDR5/L/kU+1B2Sn
	5et4qbjo7SJ9TRdiP7ft15eIZpTkJMFQoU8Dq/rKIekkfE4QQBh2zxTccAwl0BP5VX1gVt8LgfR
	jzXomhk6PFdqzmjgP6n9GrRxu0UH1qheG3IoaZF6IO5DMynwh0O2VMvQ18hyc7RdQBuVuJFswVZ
	RAk1GBYeVva9haFX/75P88gkt2fVeoT5DfYdfcxUqpmXq9+9nlo2unvWRyp6XcOcSA9oNwu+V9t
	wmggoF9NvFTXe8CXcT/2mtG7+7iMUxDWhxMk7xA7p+pIFFaB+hSl4iGnBVGD/oPwPq17yFgVOBK
	Qa0I4b7Kfc6WRcqXSBerMtkfbLLMLTqCAx
X-Received: by 2002:a05:7022:4395:b0:11d:f440:b758 with SMTP id a92af1059eb24-12739829f69mr179121c88.25.1770931331418;
        Thu, 12 Feb 2026 13:22:11 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6fe357sm5577294c88.16.2026.02.12.13.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 13:22:11 -0800 (PST)
Message-ID: <3bf72620-88ac-4c56-b3ec-0fcfa53c14c8@gmail.com>
Date: Thu, 12 Feb 2026 13:22:09 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] improve per-node allocation and reclaim visibility
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
 david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
 jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
 mhocko@suse.com, rppt@kernel.org, muchun.song@linux.dev,
 zhengqi.arch@bytedance.com, rakie.kim@sk.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, surenb@google.com, virtualization@lists.linux.dev,
 vbabka@suse.cz, weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <aY1dusLPzP2AHP6f@casper.infradead.org>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <aY1dusLPzP2AHP6f@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13913-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,suse.com,linux.dev,bytedance.com,lists.linux.dev,suse.cz,linux.alibaba.com,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87BFD131378
X-Rspamd-Action: no action

On 2/11/26 8:57 PM, Matthew Wilcox wrote:
> On Wed, Feb 11, 2026 at 08:51:07PM -0800, JP Kobryn wrote:
>> We sometimes find ourselves in situations where reclaim kicks in, yet there
> 
> who is we?  you haven't indicated any affiliation in your tags.

Meta. Is there a preferred way of indicating this?

