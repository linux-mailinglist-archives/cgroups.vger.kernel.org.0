Return-Path: <cgroups+bounces-15176-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MUvCg2c0Gkd9wYAu9opvQ
	(envelope-from <cgroups+bounces-15176-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Apr 2026 07:05:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7885B399F7D
	for <lists+cgroups@lfdr.de>; Sat, 04 Apr 2026 07:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE96C3050218
	for <lists+cgroups@lfdr.de>; Sat,  4 Apr 2026 05:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E839B36D51E;
	Sat,  4 Apr 2026 05:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8dAZaJk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF1A2FBDFD
	for <cgroups@vger.kernel.org>; Sat,  4 Apr 2026 05:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775279034; cv=none; b=dBaM67vbv3CJs80hE4t6Kk4iDm/4BXlXlFEUlIeYQ2wAYt7vOwsgCkQuKcfpfIT2A4bczqCc3ryJay2orHk5uouIbY+eaLs2lMg+1LyrydJ2DtdcXeQPc/77O+FDfVb4hXbzTEGO+MamZqdJ8tv69vLHWlAdGDL8derLBAs+kic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775279034; c=relaxed/simple;
	bh=ze4+74oYJp3RxYPROmdobkVcnwol8pUjbeXvBsqyDzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPtgQBNB2V4xu3ozxSPrsxwDO8XtiFCJehnZflVbZjZgoN3b3LOCR8buDgGaBavBh1EOwFFawlGDqr1S2AEsxWUKhRfaB15+DsXe/IuBQUSAiqrbfG7Y6NpLvq8j6hdchdl4fmcSHhSooX9Ooe+C+RBE6QxblY4PNZPE5WBpGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8dAZaJk; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d9d929e27aso2258169a34.2
        for <cgroups@vger.kernel.org>; Fri, 03 Apr 2026 22:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775279032; x=1775883832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfHSpbLXBsMlAl1URSV/gwiOLc9oaa/SNwCNcyDSw4o=;
        b=L8dAZaJkhvww05eyEaBCos8XpFKM2ypagkVSOtisUzGWqLdLAqQy/h4u/K54opJ3QD
         BR7ac6ItfkjY2NeZ06vgKSnzf0BVAj0anJ3SJvs46FLu0AAsSfq8FRUe5x+OOni+Z65G
         XQva9iL9kZBPPaN1gg5oCvbW3+kJXsRURxwyJwEhs8b2PF3ecm/AbY97zNRiNw2LvRyE
         lqvExZeLTV/GbiaCMu07WClJ1rgaS45i9KoE3u1U2nlLSP0d4zqeOaCQ85kDO5GYrE1z
         4spuy+FhA7Lnd1+nOBERO7SQUAGdwIWtoNUIH1g4FymkbCVQ3YZYaLXSc5L+pfLs3dQr
         IkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775279032; x=1775883832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sfHSpbLXBsMlAl1URSV/gwiOLc9oaa/SNwCNcyDSw4o=;
        b=o0xW6HHLBJkUr+EBuDG5eeRfADhPa7B1Y32QOP9Iy4CsT/EvijOZ9RC9evY8MhzR9o
         LvYm12/UGrtZcLMoBKcejA3unWASgXSzYSUvSdBMwe8+vOfNpdZE1gNO87qnx+RYePBO
         Hj00XNEYCXoCcR6DgDyH/xcT6xfI3/DJOe/Es+y+Co4R3wkKNls73kLcShus8anrMG50
         o8WZsq96ZBveQh2Pvqoy1vk291nRHvbBRC6xyRhhIMUnX5s5TIErwT190iRPdzw5aGkJ
         XFH+KQMVWTTSXjcdADc8UyKSnZeoT/3eu/vqcHUamMeDtrqxJ/u3n0GWIMcxTvnEr+x3
         R9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXbcDs1Rr8jLeHTmQLCo9Zr7xa0Xf5UgR3Q/pcEIY6y+REw9saRLN5ctnNn1W2plHJnfKApld3g@vger.kernel.org
X-Gm-Message-State: AOJu0YzJztXLWj5shR5dGKfVHR/X/zCiZDMPg/7jimDNH35bSkNlQdsh
	9pqYpJ4POcaxDZBXedVPxfuDIeCcJEvFYFJGsAOkdHu248U+fMnhRZIVHsA0pw==
X-Gm-Gg: AeBDieuiBszLUs4hJHSF0+X8t5AyCp496Gl9sbYZ+DmaLsWI5FeUxLdP3+h1IY4Wyou
	eM/vRQLufV9UCwHDWynSRgP3T/9mJOnEmwcU4nd7qYb5TbQ14ov8yu452U2oxg6lQ1545QL237M
	jSremUlM6dZGezdYjQQ9CXQND+YnVMduMZHI1e67e8jlPoCrVIRS1Xji4XRk6pUWPDfrvtXQR9u
	UMNbGQiEQUqS+dhZ4vfsCAv4+FoBQWHT6zVLPo2Z6y0O74Ywm12yku+d7dPVFbcqoiGXB+hxPLi
	R9Bh4QTXwJ4Y8WNb0usSfO3NZeQaIv76y1YW0h34QhRsQmt0bTltiDrslAkHm72An0hfU/VACsZ
	BzXqGVKrLTpybEGoO2s7mjhKHAtdV15ZXTW8x5kg9I3a1XbeIUkNbssTERhI9VIuaMbX1mUC9uB
	/1J5KNw1zSYYhlz0TYqY50TQ==
X-Received: by 2002:a05:6830:6203:b0:7d9:d2b6:155c with SMTP id 46e09a7af769-7dbb6ee7f3cmr3593469a34.2.1775279032484;
        Fri, 03 Apr 2026 22:03:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba715bd95sm5622147a34.8.2026.04.03.22.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 22:03:51 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>,
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
Subject: Re: [PATCH v2] mm/percpu, memcontrol: Per-memcg-lruvec percpu accounting
Date: Fri,  3 Apr 2026 22:03:48 -0700
Message-ID: <20260404050348.2787292-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <adCaF0jpayWn6-FR@casper.infradead.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15176-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7885B399F7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 4 Apr 2026 05:56:55 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Apr 03, 2026 at 08:38:43PM -0700, Joshua Hahn wrote:
> > +EXPORT_SYMBOL(mod_memcg_lruvec_state);
> 
> What module uses this symbol?

Hello Matthew, thank you for reviewing my patch!

Whoops, no module uses this symbol in this patch. I was working on a similar
patch series (accounting zswap statistics on a per-lruvec level [1]) where I did
the same thing, and needed to export this so that using it in zsmalloc
wouldn't break if zram was built as a module.

Obviously there's no need for exporting for this patch but I forgot to drop
that part when copying this over from that series. Sorry for the noise!

Thanks again for catching this. I hope you have a great day!
Joshua

[1] https://lore.kernel.org/all/20260311195153.4013476-10-joshua.hahnjy@gmail.com/

