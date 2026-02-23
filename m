Return-Path: <cgroups+bounces-14165-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CKRIjWvnGmYJwQAu9opvQ
	(envelope-from <cgroups+bounces-14165-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 20:49:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC417C845
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 20:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB1353044361
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE45A374752;
	Mon, 23 Feb 2026 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gicuyZlf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491B9369232
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876137; cv=none; b=NpCEsam2e8m0g7qeX515wpzDL4cbAQZGgzqN1Fez/ajPeE3dBdqRjexhbuO7+Erm/ZLKolsefgMyrwrQZTFDwEIv7ARWHDJdye4ujKR39l1Macl9v4EiUgxZLe0YyqbLEMQzf/Pdt8fmGg+2BO8SYlXWuJngkrTR9n1eNRHafyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876137; c=relaxed/simple;
	bh=1IWpxI2I9usNquKpOzjiVFlKc+bt6yqhK96XknJK9RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evMO+PAR6PjlXdRP2Lg5Mnh1U/RVboXiDD+D+7e05GRkyFwGuOzUtPjPz4aYKr0CuwcnAkKgTO3hUV5PA3fRb16GMfrF0OLaiBbqwi+rVnPP8CnaMjxcup8hdzXYkZ8g9NI1WeBhPQyEjBFTXlZLXUVL0QvzZ5kvyG3mBTRRwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gicuyZlf; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-45f171cb842so3433785b6e.1
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 11:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771876134; x=1772480934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/INDuD5oX/oIvPRSYGNo5VYV57G9J3tLcJGQ9mtqQk=;
        b=gicuyZlfvtKyVQxAj9d1qAZSNPYKNqxXdxsNzcGKQ+M7EwOf0mMAVmN1RNWbO08Zre
         sVT6ktSUPeYCcovREdh5XYMIMv5jCteqWxbDNYlP8RvyUu+CJ8cXGeSIXnOwmRJAuaG6
         lNC14wcXgUzTRE1+XVKtWNG2fAYC8K7+ETDA09ritbO7jfmul+oVZFOeIXhZ0pW1/f1Z
         GiW3XgcKxTB264ZzBKuao+321O4jU/e33OYqAn68wGKaOY7X4pg7LA3bqFMaD2RVnAsd
         TSkmEktSfixHiOC7+zFEDcenYeMklqBNTMZRn+y3w8hUoN0/L3TodMEtssOtXOttLKtW
         eXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771876134; x=1772480934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/INDuD5oX/oIvPRSYGNo5VYV57G9J3tLcJGQ9mtqQk=;
        b=rV/JWWzipbfqZgZ12C1pYChKZzFaVrS8mdY3pqb7Xnv3RjUvjRco/RuOL+KC1nS1QC
         yiaNcWFeE5i99zNJypno3IAzygh2Y0LLGlf1l+ZWujXPSfkQMgP8+7IrNy54WZIVD/MK
         i1GROAcK0AzMQ/9Lih9EY6qjyl5/5mQYYCTfzXlSHByykwBFrrbrqoGC6A3x/VRBtFyY
         JRT24F8INZazrJlDmV6m5WF0PVMhjSMa4qKAuENK9EkKUKT2OqZIjXqewMoKU7VZtJ8h
         Z5+WCpofz+nMIEOl8e7A2H/XV+MULx7iNDiL0qiPYHRsxoz6QuGnXLBKJN/lmYqKLYWK
         vvjA==
X-Forwarded-Encrypted: i=1; AJvYcCW9AP3Jk2J+Ji478CqD1XUtzdbsHqknYW+BaPn1VOXasNhZd4u7jjp7/Psrs2hz6HbkeoEPeRi/@vger.kernel.org
X-Gm-Message-State: AOJu0YwlgQMIjlGQedKjk+a9H0PTkY295Ba97WUgQbaFnRePOoGGcsk9
	bmA/D5maYp9z88xefaw+gBIkD82n/ZrEYbwcuSXL26T3+7rFcM+ptKJE
X-Gm-Gg: AZuq6aKexVLJAH06pG7l68u0DGuUyRZ+0AIc3CxEdr6MEcUe8hn/FIwV8B4x+kqkOET
	7StjgdDnD+nYp1zhVxQCUGrnSj9523VOD2tnQleEtfAnCZqQA6C1oGaMdi+W1SQMX4LHlGRhlYI
	ilT9Lh7WuNhvrEZsk24aMZDyaDRKPk2BK5iMVIR0GfI2RR0b9QKjmq1bO54RdM7uiqQkJrL9HIA
	nrg/Smgk87OnRk3XCNQqCAPNNNL7ISnGtUDIBo+lndcUM028MQ0h1BFqDPkg+TgrubqT58m3/9m
	ziLLriGcA3eBcyb+OmALQGFMsEgnap+tLPw4kIS3bbYYbz2JcEU4G4K9nDe/46eCAPQb6/kyYEb
	TV0bUzIN2iOVe89YJyWLGyNQ8xYsjXpyy9NESMVvhh0kiqxSGrurjtC3kvdnVm30gIlpb8jhj1r
	Oyta5JF3FLTxTkOWGqfioke1U1PKNBTxU7HEbqK3oYYbQtZL92
X-Received: by 2002:a05:6808:30a0:b0:45e:f078:2d0f with SMTP id 5614622812f47-46447273793mr5550871b6e.30.1771876134191;
        Mon, 23 Feb 2026 11:48:54 -0800 (PST)
Received: from fedora ([2603:8080:10f0:ab80::1382])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46460661eeesm3113255b6e.13.2026.02.23.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:48:53 -0800 (PST)
Date: Mon, 23 Feb 2026 11:48:50 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: memcontrol: switch to native NR_VMALLOC
 vmstat counter
Message-ID: <aZyvIhCmVbKWeBL3@fedora>
References: <20260223160147.3792777-1-hannes@cmpxchg.org>
 <20260223160147.3792777-2-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223160147.3792777-2-hannes@cmpxchg.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14165-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,suse.com,linux.dev,kvack.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishalmoola@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Queue-Id: 06AC417C845
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 11:01:07AM -0500, Johannes Weiner wrote:
> Eliminates the custom memcg counter and results in a single,
> consolidated accounting call in vmalloc code.
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

