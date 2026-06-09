Return-Path: <cgroups+bounces-16752-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FNFOFBqGJ2omygIAu9opvQ
	(envelope-from <cgroups+bounces-16752-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 05:18:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B38365C029
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 05:18:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=F1DkyNrA;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16752-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16752-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 269CF3020ADF
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 03:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF67367B7D;
	Tue,  9 Jun 2026 03:18:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A80367B6B
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 03:18:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780975122; cv=none; b=p1xlOW/UyKwlgxDcZmTcjk+ARnCS7wtMZBa1Pa0V+F8tXfzLFWqPZPfXXYsEBs3MDAAox+uuumbWTCXcifjds2dShliv9UDtDcWQk3tjwNfkpnpxXft4TUUNdnbSoaK1P2HaZiGEKmcSgNqziNVUVAu8rketVqvf4GcfvYc88v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780975122; c=relaxed/simple;
	bh=yESwecBwMv/jD2yQrJM4oBpPmBZy0jCTscK7ky2wtrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FajVTtRam8loDTPgcTuC7xWBJc2XE1OVENEPMRDUbWjXz137AzUbMZYCRrr3U84wxst0TAqO+IjdzybUIjkldF6iPAWl3+HkBc8anbGT2/Eu+HtrDwaLXSSQFqbbe43G0I+EgY/dTbu8Zd1Sfczl9a3hrOMZSvbILVxwNxhw4r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1DkyNrA; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so3395264a91.1
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 20:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780975120; x=1781579920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8MhYUiXWRAVVrdhX1Xj1vk/zHhvhBV8KDCeIyuVj2g=;
        b=F1DkyNrAn358F/khTOVTxqVTN/gI+4PsSZBEeNj6zsve4FaIgH58VGz5i9Bo4+dDgq
         bQBV4dXk4GO7RgIZbh7D+kzW3/nqEo9laD6GDgeYz/NPLhG2/QqQYhUczc72KZWoNLSE
         +mPyxnwsfwRYKur6MG6yfS97F+55tOi+HmjcGWQc0ZvtQEF9vCrGic2h7VgmYeJuRkUG
         lERMzi+CtBUxC8LgdGC1D8xxARX23ahSh1JqIki1wbGopOAsX11MHbwdvvZFTrzEy9f+
         XaJ9a1huLjRyT4K4VJwpAvuozAUl2N/QAo3Op8eYUNhRfpa4+ymGQxulj2IxAVaKqcOM
         DAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780975120; x=1781579920;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8MhYUiXWRAVVrdhX1Xj1vk/zHhvhBV8KDCeIyuVj2g=;
        b=Pv5Om3CCMke1fkTiKFHta88mBEcUoJtt92WynGSrbNoGO1fmnOgFSKlVld6sp1+nyj
         G+kmCljdCwEp2cGqq4g+J5Xt3uCwocxk2VN4ozWNxGl+EivF3st4QERWCa+AkDJCVvbs
         zw65tOfbNsEFsxHULt+Wxh9FbUYx+Z6Bvpf4FlvkI/ErpA1RBd7HwlwqXHMhxCG9S7cb
         0ihoxgIlsclAv4C4bt4TGB0t+2vPEwdllrbEDQsBZrATJAjwkgrlhJkJS2kdDqHJHujN
         PaifB0jca3XchpoTr5ukBlci5mshbx2ckJJT7kM4gFX451KirYqBD59bHCr89GFu0nRA
         v5KA==
X-Forwarded-Encrypted: i=1; AFNElJ+9jMDPNS8x7CXj7HlrL1OGZqUJL9BWuqNJc7h0FlV5OwUKtzLvth84tokPWogN+GJ2fojtidA/@vger.kernel.org
X-Gm-Message-State: AOJu0YzsiVnxJYbwC0rWTI39OXCGov7m/4nNBkc7uUHjl2V110mgig4D
	Pcub03MOIXBQNOMp36zp94/bFmAdalGI05tHOQHVGiHzxXdJNvq7rJe9
X-Gm-Gg: Acq92OFVGEFswfEZfy7PNA+SHJEhY1c1zAufyC2akRfKMZo2g/yCW/lpFb2DqZ6WCE8
	maXRcLa+lDKVDazfqb2XH/z8UAUxXIMTEL7e57nL2ut/vh80ci5Y1HWWx2VYD9kAK5wjtHcm1t5
	UK1FAKY/O86V93siObj6sIjBaYi2AUBcmCraUfAgZu34h+MQzN6WO6BmoV4PfNdLlfS41NicJvr
	bJZEI93Lr5Q4vb8s55kUk1x65NxRyJWcwhLhHsPEowIeuGsx8arn4AGQidIaBuK3hof2BgV2u/C
	zgsU+4nkqv6ZWPurD+ePOhwsuBOIO1OoU8GTISjNnHtjOR+gIFWcrhuETeNJzU/Rphc2EtGPjqO
	MrW+9JJbrRRvDcBzXig5E8iZsfCucvQH7Ls7AusJQqqHmEXC9CFXkiq8Rhn8YgOMLErHE74oDhO
	6rrUX41roFLt/OGIW2/FXPVexbVnjWx0tha0OWrn9s54v8uGz4Q5P8dA==
X-Received: by 2002:a17:90b:1809:b0:368:6998:b49d with SMTP id 98e67ed59e1d1-370eeff6b37mr20150357a91.10.1780975119848;
        Mon, 08 Jun 2026 20:18:39 -0700 (PDT)
Received: from [10.125.192.72] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8bc5asm204871655ad.27.2026.06.08.20.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 20:18:39 -0700 (PDT)
Message-ID: <1c25650e-bf98-2863-d505-9b94c385668b@gmail.com>
Date: Tue, 9 Jun 2026 11:18:26 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor
 per-memcg
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry@kernel.org>,
 shakeel.butt@linux.dev
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org,
 mhocko@kernel.org, mkoutny@suse.com, chengming.zhou@linux.dev,
 muchun.song@linux.dev, roman.gushchin@linux.dev, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com>
 <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com>
 <ah4ZZGl7GYJf54Wz@google.com>
 <ff344c9f-51da-8b3a-e7a9-c4a7f4702ef8@gmail.com>
 <ah9i3uhh3PFiS0Uk@google.com>
 <c7870fe2-3588-79db-cbfb-bd6a2b78f594@gmail.com>
 <aiBpibRNi0BcM1Zu@google.com>
 <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com>
 <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
 <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com>
 <CAKEwX=MQ3xXBAY-2H8vA+XSX5GHNBubJ2GCYAXGD+Hra++ZM7A@mail.gmail.com>
 <90730fa7-62e7-d5f4-b638-23b22a8509f2@gmail.com>
 <CAKEwX=PF9hfERC_QMq+rjkSc-BsJyawMgTe+EhwR_86HiQKm=Q@mail.gmail.com>
 <CAO9r8zN6VVZz7dpjNrh8n7wbLkqcrsROPm70MQQxO49HJSmMFw@mail.gmail.com>
 <CAKEwX=MCFbsh9ndBtR0-bGRr_=v-6bBwTo=muzd9ZSD-LAK1nQ@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAKEwX=MCFbsh9ndBtR0-bGRr_=v-6bBwTo=muzd9ZSD-LAK1nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:yosry@kernel.org,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16752-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B38365C029



On 2026/6/9 02:01, Nhat Pham wrote:
> On Mon, Jun 8, 2026 at 9:48 AM Yosry Ahmed <yosry@kernel.org> wrote:
>>
>>> But OTOH, this does seem like a recipe for inefficient reclaim. We
>>> might exhaust hotter memory of a cgroup while sparing colder memory of
>>> another cgroup... But maybe if they're all cold anyway, then who
>>> cares, and eventually you'll get to the cold stuff of other child?
>>
>> Forgot to respond to this part, the unfairness is limited to the batch
>> size per-invocation, so it should be fine as long as you don't divide
>> the amount over 100 iterations for some reason. Also yes, all memory
>> in zswap is cold, the relative coldness is not that important (e.g.
>> compared to relative coldness during reclaim).
> 
> Ok then yeah, I think we should shelve per-memcg cursor for the next
> version. Down the line, if we have more data that unfairness is an
> issue, we can always fix it. One step at a time :)

Thanks a lot to Yosry, Nhat, and Shakeel for the great suggestions!

Let me summarize what I plan to do in the next version to make sure we 
are on the same page:

  - Drop the per-memcg cursor and keep the root cgroup cursor 
(zswap_next_shrink) logic intact.
  - Stick to using the zswap_writeback_only key, and change the 
proactive writeback size to use the compressed size.
  - Consolidate and reuse the logic between shrink_worker() and 
shrink_memcg(). Enable batch writeback in the shrink_worker() path, 
while keeping the writeback behavior in the zswap_store() path unchanged.

Please let me know if I missed or misunderstood anything. Thanks again 
for clearing things up!

Thanks，
Hao

