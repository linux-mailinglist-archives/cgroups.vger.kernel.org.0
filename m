Return-Path: <cgroups+bounces-16473-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKliCpM8GmqR2QgAu9opvQ
	(envelope-from <cgroups+bounces-16473-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 03:25:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E61C60AC25
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 03:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8447D301CC7F
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 01:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6D86334;
	Sat, 30 May 2026 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpgY9CCX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C526F28D
	for <cgroups@vger.kernel.org>; Sat, 30 May 2026 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780104313; cv=none; b=Xt0yT3Qc8OH6B4Pdk7sQF2EmmNubTnexqAf2gqeLh7V/97eQ2uTPWGUOkn/D9LhA2ZYkvvCnjC3Vc9pr6TQwA+QUHRtuODRZamwspBM5zbVot9fYivG/TLSWLg98+UG77n7laiqhEZmIPqqrwRmtFZQPsTATl8qhF1ECm2uwJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780104313; c=relaxed/simple;
	bh=VXHmww2kmAiStU1LtDb87dJBC0iCRH3nmBh0AQEIFsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnBJD1uKzZfQIFSOfyCrNeva7TZbAA0DTMJLZOLxKuSpCfaYBxgnqD3Ib5gLuVQvrjWFEJmfLLpINIM6qlgn8bv1yVBJNMEA0gBbwkGtvezpbKtZlcVTj0drp8tzuy1Rf/TTzIpOSKzOZAYeQvKIapNL5IDVmTKiBDQD7vIigc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpgY9CCX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd9a71b565aso1825459166b.0
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 18:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780104309; x=1780709109; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blzWfs+CdYUoQumGPXqABGcwSvz3mulcURHwgoS7ZCY=;
        b=HpgY9CCXDGiwoy2lVarMJStV/6ujZkoakylS74rNJdMtxSpF+kM2W6hU+wYGo4+fxS
         7bEJ5Ue2CAX1gxl/Km0N7GBiIai9Ls8MzFRoYVIJrsXQbeqBE0yRs1IjcWCP9xyHvKgG
         pNMZtdhaoTmZFKoOkh57J0d1/0I0Nh+0Oft00czQPFU0a12ZvZEcQ9tAg86ke3GzZdmn
         KJQBZFRYU74r0EXZzwc0cphR5ldQubLtVrIbJSTTi+42a3HANZdl/lkWCX66ooEf6kO1
         dAv54SlswANszwtue3J6/Zi5zX694ZSVhU5HKRExm+0IsnmHCiFd5XU4eKOKmsxh80s2
         53ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780104309; x=1780709109;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blzWfs+CdYUoQumGPXqABGcwSvz3mulcURHwgoS7ZCY=;
        b=I5SfMrDF5iAXKOI+R8+UqzP2v7zPD0H54eHfm4/8nSdk2WgjWkmpjNJUfj7UJ0OV58
         t23WccYZHLbavaI68o1+J2ZjjmGgi1FtUZtKODgiWhOptE2FVMW55EJGyiu/NDplQbj2
         xJM+XMx22YScbCH5T/4WJtrUA/UkchkeWTXjrsWg3l8LBSg1Mw5U2IsHEmWs2MosOAb3
         ixS2GcuLg0uXs1fzrQpaCOANHLZ1sVPU4fdME1OOKxRp2j1TPH6Yq9eSkiBTB8k3GZPN
         tXh1krnaJnA/d7b2JycMx6Cy4sp+kzFk8As/8scxXZXdqfyeyBPze68lCRC4vxL9k7qn
         jIjw==
X-Forwarded-Encrypted: i=1; AFNElJ+ycmmd5hLixR/Csg/aULlDBhjz3LRdykzKrHi8or6eZgaW1bBp/b3rJR1i5ZuhWpZdKD/d5o6z@vger.kernel.org
X-Gm-Message-State: AOJu0Yylc2tBwbhIv8e0brHhdg76WvXJB+EHx4n1Yb8AD+SypiN9ZqbH
	TvIM+b8OTGGg/f1mljXdOA7UOYA2Pr+CSn9DTxIu8ZxkD1vvXmEpFeZ6
X-Gm-Gg: Acq92OEwAZMaFJ4wdyPSYByTYRr06Cu2SbQrKRDU7fWm8tgSGFHJP/sWbO3PPcJlbN+
	bT/5wojXq+IF4ZVWQz4dKgrkk2ddD9XAwRy56xDYSQPKpDvLrC0oIFI1kjH/rRqkppHjfjVLL1S
	OnTXmBRkpy7hsR70+/EtuVfDu0L5T1XURmiJsy42pPBtQBP45utgEH6ArOi3X6SbO++bXckqGOi
	yVZGCet4yKd7wO6ZceXTsOdqI5ClnbLceyxDVH+sFdRfCwq8c7ro6oB9uYYavVEJ4VlMqAr+x6g
	ZWpb9J3jX3H3InIDZCZImqCAw1XskSPgtFdlbg0bSO8Hob+FHL5ACByYW2p3iwnUMLmQW7+OSgW
	TRZJgpst4F78fk7BIw3h299XBJIp177I3fet64qDBGAtMCiXtmCCyOqByqHQZRuyN/WljwqPifh
	+i6U4pvVCKYLEQIk20bhhE3/Ga6n81rirzl7MEbucAAkI=
X-Received: by 2002:a17:906:c10f:b0:bd5:7a3:a590 with SMTP id a640c23a62f3a-beab6cba322mr85730566b.47.1780104308756;
        Fri, 29 May 2026 18:25:08 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9d27f224bsm114374166b.3.2026.05.29.18.25.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2026 18:25:07 -0700 (PDT)
Date: Sat, 30 May 2026 01:25:06 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] mm: list_lru: deduplicate lock_list_lru()
Message-ID: <20260530012506.yui5w25n3axgzpoc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
 <20260527204757.2544958-6-hannes@cmpxchg.org>
 <20260529095628.nagjdy3f24z6qjtk@master>
 <ahmXqjQ0Vz4pb4u1@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahmXqjQ0Vz4pb4u1@cmpxchg.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16473-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,linux.dev:email,infradead.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 9E61C60AC25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 09:42:02AM -0400, Johannes Weiner wrote:
>On Fri, May 29, 2026 at 09:56:28AM +0000, Wei Yang wrote:
>> On Wed, May 27, 2026 at 04:45:12PM -0400, Johannes Weiner wrote:
>> >The MEMCG and !MEMCG paths have the same pattern. Share the code.
>> >
>> >Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
>> >Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>> >Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
>> >Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>> >Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
>> >---
>> > mm/list_lru.c | 21 +++++++++------------
>> > 1 file changed, 9 insertions(+), 12 deletions(-)
>> >
>> >diff --git a/mm/list_lru.c b/mm/list_lru.c
>> >index 7d0523e44010..fdb3fe2ea64f 100644
>> >--- a/mm/list_lru.c
>> >+++ b/mm/list_lru.c
>> >@@ -15,6 +15,14 @@
>> > #include "slab.h"
>> > #include "internal.h"
>> 
>> Hi, Johannes
>> 
>> One very tiny nit below.
>> 
>> > 
>> >+static inline void lock_list_lru(struct list_lru_one *l, bool irq)
>> 
>> Here we use @irq.
>> 
>> >+{
>> >+	if (irq)
>> >+		spin_lock_irq(&l->lock);
>> >+	else
>> >+		spin_lock(&l->lock);
>> >+}
>> >+
>> > static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
>> 
>> Here we use @irq_off.
>> 
>> Do you think it would be nicer to unify the parameter name?
>
>Yes, I think it would be nicer.
>
>Note that I inherited this - we had irq on the lock and irq_off on the
>unlock before already. I didn't want to mix even more yak shaving prep
>patches into this series.

Reasonable.

>
>Mind sending a follow-up patch on top of mm-unstable?

Thanks, I am glad to.

Since this is trivial, I would wait until everything is settle down.

Looks good to you?

-- 
Wei Yang
Help you, Help me

