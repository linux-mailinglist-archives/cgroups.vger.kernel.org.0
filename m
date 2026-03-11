Return-Path: <cgroups+bounces-14743-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL1IM8WwsGnGmAIAu9opvQ
	(envelope-from <cgroups+bounces-14743-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 01:01:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9E1259749
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 01:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 844D33120567
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 00:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D781F4315A;
	Wed, 11 Mar 2026 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4OUXF0X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A643846F
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773187266; cv=none; b=rVLFDCoei5HxkYj6phX9hz8T77bmQQkjhOqBleM340wlvzhrMCIMPUa/6GvrLCR4popNZ8BpWONdkhASmEh6IlmEED82VlXUYnvp13BXFnTz7i8d+098y+yLu+UVYCNA+FxYzHsY+A1CEg0gqq0VfvKecR/ySkIObJyrIC2MZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773187266; c=relaxed/simple;
	bh=WPQTlOy4+7EdwLH1HzvDEbIl1rugHmya/5VpKkfZU3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=DKN3weaVhdiRwzQT3N4chIR5uzaTXSi6EbdDf6aNCjAKLCixScQ7os9lLjlKcLHCVU8EWMje7WZ8vcgjZbGBQm+6Zrl2h4DTrutrlaE9Hed42jUjADDsX69vKpvvfQgHD7k2gDAWtGvHPGOrm+3fcZMRdZWBKXXtX63PDO6qdXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4OUXF0X; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48541edecf9so20115915e9.1
        for <cgroups@vger.kernel.org>; Tue, 10 Mar 2026 17:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773187264; x=1773792064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/eEDdOnuoN+4uXFeXQVdnNuy5kSNMswYGhV2JxYSYJ0=;
        b=M4OUXF0X+hcXS1wiesAHuhqlu5lgYI2DIvvAtxTPUQFqUZjkDPmmDfm/+9KLJzA3bw
         Kv4pVt2S2clVEgYQVC15VS/U8JeOcMfyrT88XJ/1IGONuqtAsSpCELgbZn0URXgXZq4Q
         C7sPNifpr4EqpEwN8JijsP9OXW910gypeg9y3KwCORZ7+feHr7phiRSiBE/h4RMeVTxN
         i+H1S4j5/6Ig7kJPyuklvUgb5EJhD+CnShbc3L8AjdqPNmL0SMpTx5Y4+e4UuYEG3vJh
         mawSRJg2v4DGZrEDCxoHu1+rlW+cRvnsHZnDDf11QmWeUQVXokNPIOCeiqgU5tZ9jn3l
         97Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773187264; x=1773792064;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eEDdOnuoN+4uXFeXQVdnNuy5kSNMswYGhV2JxYSYJ0=;
        b=tymQCPdNZTS/JX4XeFZCBIwgR8dTBDWmDqQuOTWCDV+2vgRasAOxm0uzPKXVPNE6l9
         8XBDGQ6LQzGYesc0NyBEO2b8uuSBCABzRBmAxIbt9U8akLG37goRtujZdYWYs8tYjCh2
         0l3Q5u334owZU3EWGSrR5HzvzIDYI09sK8SY80SwdOA5imVUPQDhEY1X6AA0JScEMdPU
         sfJ4uVgThOeihIM1NxpfyyNVEIzkeUQoStCV4fCmEyosm2bmRtHcAfix0nFDXfYEGC1k
         AU2EkbduX41OtGsKuMvZ1WFwiVvrvaQ9quwwYmLvSotOlaPrfU6QheD/ROJUDypNwwcv
         kGnA==
X-Forwarded-Encrypted: i=1; AJvYcCV4Cm/k50psgGiISVEIlchKj30GN1wZY+uwRwWy1LuTv+yvVNtvKr8w3nAaSXbblewUc3qUXxez@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwyxdl7eicF7pLI8w2mtAINV3jnaZ5elwyyeZT9GJVdcT9fgw
	2UYpALMxrb7WFLxkvgVghrH6LtK5KC99M23Ryou8LQjLY6zV+aEzWQUs
X-Gm-Gg: ATEYQzxldqlcLxLidw6Z2k69o5BOkO0wdmQsOJHEBGicbKASdFZHeSXihUFDZB+4650
	4KENtOie/2kH11l3VIjJuOgmb0V9RjHZBR8OADH87GlhtjbhCPil2A2YBhwLYbQaMBvcfKM7esK
	cQ+Uv8GBn9fLV0Yt0V3GJYhU6TwaRCzjzeSHglH7gml9zmt8rAIo+mE2Cm/OSnDiaTZaSGT3QXK
	Q1Ipx2E8DAJF4X9wXYeybAudHGoYikLi76sdEnA9kFghXYEXweRQiYwPg7NDRW9Ky2FMpA2Ne24
	eBWTU7pgmAlcp3gqcxwj04jFxxKieqRcWIiGcnhitZXQJvRwvvu1cc2rftzdZ8kur0WFA/z/9CC
	eioN014lYJNqrCL47xP7iJINWNzYD/WcghY+5Zn39OIsW7XDqPAx9zxX9ExVxveClcb3OG/b8Qo
	ZDXjzLd6Y8GQP5HJklVuXedNxMA6I9rINQJKk=
X-Received: by 2002:a05:600c:1383:b0:485:2fe9:3375 with SMTP id 5b1f17b1804b1-4854b0bff59mr10920345e9.15.1773187263637;
        Tue, 10 Mar 2026 17:01:03 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:1b2a:fa01:9944:6a8c:dc37:eba5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0bff95sm7638015e9.3.2026.03.10.17.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:01:02 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Date: Tue, 10 Mar 2026 21:01:00 -0300
Message-ID: <abCwvB36SLGC_7Yg@WindFlash>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cbd42744-31e1-439c-b0f0-0cad052d3d9b@kernel.org>
References: <aYxviLoWsrLqDU7o@tpad> <aYywl1hdBQP2_slo@tiehlicka> <aZDw6xI2izFDfuuu@WindFlash> <aZL45yORfkNvS9Rs@tiehlicka> <aZjY9h3XXMNY-Ytd@WindFlash> <aZwYmNuucBspCYhk@tiehlicka> <aaJDjmnfuo8AM6J9@WindFlash> <aaYpICV55B70U1I2@tpad> <aa20uDGqnmiqYJ1w@WindFlash> <cbd42744-31e1-439c-b0f0-0cad052d3d9b@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC9E1259749
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14743-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,suse.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,linutronix.de,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leobrasc@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 10:52:55AM +0100, Vlastimil Babka (SUSE) wrote:
> On 3/8/26 18:41, Leonardo Bras wrote:
> > Hi Marcelo,
> > 
> > Great, hiding migrate_disable under the static branch is the best scenario.
> > 
> > I wonder why we spend 2 cycles on the static branches, though, should be 
> > close to nothing unless the branch predictor is too busy already. Well, we 
> 
> AFAIK static branches are runtime patched to non-conditional jumps or nops,
> so there's nothing left for the branch predictor to do. Or maybe I
> misunderstand your comment.
> It does however increase code footprint and thus instruction cache usage, so
> maybe that's an effect of that.

Oh, I was not aware of that part. Since we can actually change the the 
branch decision variable in runtime, I guessed that it was just a optimized 
way for the processor to use the branch predictor.

If it makes a non-conditional branch is even better then.

Thanks!
Leo

> 
> > can always try to optimize in a different way.
> > 
> > Thanks for the effort on this!
> > Leo

