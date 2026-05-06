Return-Path: <cgroups+bounces-15645-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCOCGNpV+2mdZgMAu9opvQ
	(envelope-from <cgroups+bounces-15645-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 16:53:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C08FE4DCA7F
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 16:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A7213116D9E
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 14:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF8F4611E5;
	Wed,  6 May 2026 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tseGfhns"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D744D682
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078632; cv=none; b=qBKhqTCsbDRxqXwrdSpHFxB/oaVcSx5d8j+HqveIYi1RVPSg5cvJnVMgHee5lDQsZ9SmPrnOcQOe2wg/aLd86h3wyRHx7W3oKYkL5+dSt1/0BjyObNEBFgxGBKuk5RVPNFeFUVCdqc2ofJQkIJpyhYQdzGi0l4T7ctOEcgX6Uv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078632; c=relaxed/simple;
	bh=8rYhAkFOKY6K/j1/wpxkQvi3y7Z+5CCbQC0nxatTUIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVH6q0/3xED/ld39HZ3+asuqJS+FjV5cJ9ilTf3/MWPAx2Caq3GunSX2NuG0gSPN9d5oo8tj03DekeEMXiwJxC00hqSxHbVjmMOP6U30GvgkjVVEOZicDHGPxjwTQc7LPVeolqk9XSiQFdhhqhcpoCptzsMwKBBBH8qp3lfmJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tseGfhns; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d7e23defbso3736277f8f.0
        for <cgroups@vger.kernel.org>; Wed, 06 May 2026 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778078629; x=1778683429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yrKfSuIFibBSjAR8E2oWzOhR6JQ9Zhv+MqRJc3mpQs=;
        b=tseGfhns4w+9L4TQ8ZT857uRRltMFzAQPmLZhCRY+EGmJq0t6AvhRuFIS2LcdgEwPw
         IWWfpzomqpb0AW+jcMqK3qZCRTT8gRjmbviSTyqQ9dMYRHQFRW81+DujnCHOO82yJrHH
         A7OG/wPvOgIRDnKkRY3WkOYZb6YW3Z4q0qxKjyamqlQJHbSw+MaIKDosfAiIEjx3/L36
         ca3De28TBjvihOBZqV3zY6GzNWXzsQYt7aLjFeVdNuIBq9wBxCiI0VNz/TLwO9dtHXlE
         gwXigjF6RVNMwLpkFJ53l9nzqb/23+nhDiUX5xhcdKIgKb31heeP4FOx84OfNNVTOGQi
         2rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778078629; x=1778683429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yrKfSuIFibBSjAR8E2oWzOhR6JQ9Zhv+MqRJc3mpQs=;
        b=dycObSe2G+TiWL2POerI2bty9EnDd9j/xzlaqUsXeZYMBouH76h5Mt6k/HE2Pdx50H
         tMk8TjBtRlYXJIQH8DXgbE9tKaTkOZBrA24lsgv3yCYfUOeULqg6gnZaz+TDh274g5nn
         g2t59AGbIMj74e4ZQgIAvs2ig91pKsHRtFiL3obtzHCr5LVRXvqOxyZY66VSPat0rjjA
         xtUGo9R9pLdZB4sCCYcUqAyi77Exz80BoHzW6ASQG2UvzjzIwJDBgG0uMnhl5EDxADqz
         m3wF1Epf5JzDHfXBsJm/WSOxiZHxi9Zi/MCtUX7McpBGQKZll1UHH0MOew5IU5iN21uw
         mvUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zAn7HEInuv4h7wjbP9Xk7H/zAoq1WS8H/oEWfxltvvwsa1xVKJQJmUKlRQE5S/r5UYxZhmt3V@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29eehiKLoAuy5X0kMbL9VvOfied8EwipGyxGLvb3tRZFXHFoU
	FOe0eiRVPlDqrvl6xz4m9dZN8S18z8O3bIXPtGwBxG6/d948TFBnocDGppgUsXCFEf0=
X-Gm-Gg: AeBDiesrJOoavOpYSlWQHioPAM1jQmJVkX41K9g+YKEXEsxqsyUwHLQM8YQoupfdRIv
	JkC56JKdLeBs7oCXsTTUlAobT03pArAdfXF+Fi2ez6Enmi+TN4EOcwhnKGOChl4tyVhHVgH6dXc
	BO7Vc+2bJ58VWUsLzE41oaP7K0MkuSRjls0y4QFTV7rJThJEGLwt7cDoYhwYkr2jjTXoQ1hegJ9
	mblzOURXB3g+Ou8dTx6JCZdMP2iTdt4cHz1kGsMpIvJHRJcHiObftSabvLmK5+uWbysJWfCPxWO
	obcqHai/S/IKdIEdSxhUupaNV/pZTZpIF/26ogYZTZN7ncezT34zY70d+urkr8rUboMGHBQaoCY
	SZjwhomL7nYHBN4gunQf6bHnehYa5RDp4GAbiOH1SNE9z7rXjA4/2Sml+ugFWyNwlkwS8r4n08a
	y9DpMZJVQZlIEFbCP2hLsBNK0UnhycLXcNktoJBjdIIo7ctg==
X-Received: by 2002:a05:6000:3106:b0:43d:300b:2285 with SMTP id ffacd0b85a97d-4515b524457mr6633850f8f.11.1778078628705;
        Wed, 06 May 2026 07:43:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([185.194.185.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960fd6sm13732451f8f.31.2026.05.06.07.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:43:47 -0700 (PDT)
Date: Wed, 6 May 2026 15:43:35 +0100
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aftTlyHYNr0B9yL3@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <b704b05e-3e65-4a73-84c0-21557b0cc38f@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b704b05e-3e65-4a73-84c0-21557b0cc38f@amd.com>
X-Rspamd-Queue-Id: C08FE4DCA7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15645-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Feb 25, 2026 at 12:40:09PM +0000, Alejandro Lucero Palau wrote:
> 
> I can see the nid param is just a "preferred nid" with alloc pages. Using
> __GFP_PRIVATE will restrict the allocation to private nodes but I think the
> idea here is:
> 
> 
> 1) I own this node
> 
> 2) Do not give me memory from another private node but from mine.
> 
> 

I mildly mis-read this question, apologies.

Multiple private nodes in the nodemask are ignored, because the nodemask
is a filter function for the fallback lists - and private nodes never
show up in the fallback lists (except for their own).

So for example

Nodes:  Normal(A,B), Private(C,D)

Fallback lists:
   A:   [A,B]
   B:   [B,A]
   C:   [C,A,B]
   D:   [D,B,A]

            combination                       |  possible result
----------------------------------------------------------------
__GFP_PRIVATE + pref_node(C) + nodemask(NULL) = (C or A or B)
__GFP_PRIVATE + pref_node(C) + nodemask(C,D)  = C
GFP_PRIVATE + pref_node(C) + nodemask(ALL)    = C

Basically private nodes are completely ignored in the nodemask, so you
cannot do fallback allocations to other private nodes.

There is no good abstraction (that I have found) to communicate
multi-private-node allocations simply because this would imply needing
private nodes to be in the fallback lists for other nodes.

Maybe there is a possibility of modifying fallback lists explicitly, but
I think that is out of scope for the first implementation.

~Gregory

