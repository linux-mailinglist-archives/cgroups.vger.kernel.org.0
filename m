Return-Path: <cgroups+bounces-5148-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC0C9A1B6D
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 09:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7741C21213
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 07:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF411CC8BD;
	Thu, 17 Oct 2024 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LvaDN6y4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF641C2459
	for <cgroups@vger.kernel.org>; Thu, 17 Oct 2024 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729149068; cv=none; b=jBoHOn1YBkmlD4WxZQuIV3Mpp0khqv3MrX+Jn1IUZqOAgqKKi0GzoeLiBWoL+EhHMPlwvoxMXycw325CwRyD4hr2/n0HSMrRkvm+b2Uq8MOZcCFg2ArZjnBT+1uy/XXqhdSVCRHn//de4ltwRNKAog8ZQIEDbUn5l2ocdTGiyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729149068; c=relaxed/simple;
	bh=l3Uydk7duhpi48eTsX3h/4LpvTxOP5SMHvfOvswHse8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGz4nmblsBaP4EAokCkm2CskxsulLEqSmDxHyeCHBI+pZm2pXOHDtBOM32Txu7ZC40WbnEfsubKwWB4bMX1CX8nIGKAB4J2ga1jIFKsku0t8VzhmxQDjvKstOLYEofaOpp6bM2STh/vNSWHTinqvZWvQcOOYnQweMbMssWx+j4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LvaDN6y4; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43140cadeaaso6285705e9.0
        for <cgroups@vger.kernel.org>; Thu, 17 Oct 2024 00:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729149064; x=1729753864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0KdVXBGhFi7dGB+P4f8qZ3lXk3mjBstSPC2oOpH8z5Y=;
        b=LvaDN6y4PNxtGDTKh51s54VGqaNcPrACs8sAhpUh7dfPbTp/CTgBLPFuXVCbZtYzCG
         WGBUC0DWE0Ug1X5DfuwUIiqg4YUgeHu+Hjpsc+kLzNsWOc62PqAL/Vv3YaL5ylqOTmh+
         cCkCKHQocEB0emmSTcE6AOheEPn1nO81855RfeW1vxGsLnjM6P2yFg77oiIOucqzcTIH
         XDsFytXxwk7sqDSzy13UX71bcczLPUjeiQfiGAobIJ4W5Xi3IWyeWC4+XR7miJr905kV
         SKJMI85dFEfq4k0h8WgzdYXb/1C9srgrsFj0h1xvkrdlyjSW3mcF/7yaFu7rDXWvzJxG
         c3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729149064; x=1729753864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KdVXBGhFi7dGB+P4f8qZ3lXk3mjBstSPC2oOpH8z5Y=;
        b=eXn2D0btD1IlkSGhW1CBbfZUsabM+o9ZVMK9CYB3gNUStA+zg8uJBXM/wqidLod19x
         ZX+onmrpYcmGWVww9rHnqxqZIxPKbPTmthdPE7ozKJJGazYiJwfipCVGME5fUBMKMsuB
         OTBu0V7IeIdOOWH1E6pb1PD+46pzeStlRQmuGb3u/qsgxbXyiVCq5T0ygwMCanvZtg/J
         kgWD9ksviqwU0KfxPg6Ooylj49ldNhbR1ImLs3X9LANHT0A7lfzd7EtaTypj94bsXROb
         Eh+k1OGE5p7NqFpDMqytQf9eLzF/2xIsSd/kdo872UCZRDOvNqNCcdjHeaWRtGPP+vy7
         TgYA==
X-Forwarded-Encrypted: i=1; AJvYcCU/vB03hgATfFgDZsJVhtP6XefZt3UnfLMVUVf0MBXEEU5K3vGLZi97pULVlSZMBogn0deq62DB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0HsNpwfijYeUaNTXSkDPiBrKyKO/2HyakVH5fTkcuKvh9FKU7
	1vjV8jOmmU3tWVaVjgNqtdcK5i/S9nh+WLZG6CmNSL8cv7jmaKVWPQH6zJ9/UDg=
X-Google-Smtp-Source: AGHT+IHS9c0AQj2cx/Fpyoxeg7T4HwlSFDWY1656nHRQ5XO23p1Tr4JtGzw0IsCtZe1nsYz0oAXgTw==
X-Received: by 2002:a05:6000:1092:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-37d552cb121mr14038233f8f.49.1729149064050;
        Thu, 17 Oct 2024 00:11:04 -0700 (PDT)
Received: from u94a (27-242-4-121.adsl.fetnet.net. [27.242.4.121])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d714f027sm12231535ab.62.2024.10.17.00.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 00:11:02 -0700 (PDT)
Date: Thu, 17 Oct 2024 15:10:50 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, xavier_qy@163.com, longman@redhat.com, 
	lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com, akpm@linux-foundation.org, 
	jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Subject: Using union-find in BPF verifier (was: Enhance union-find with KUnit
 tests and optimization improvements)
Message-ID: <aci6pn57bqjfcshbak7ekxb7zr5zz72u3rxyu4zbp5w3mvljx2@b4rn2e4rb4rl>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
 <ZwQJ_hQENEE7uj0q@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwQJ_hQENEE7uj0q@slm.duckdns.org>

Michal mentioned lib/union_find.c during a discussion. I think we may
have a use for in BPF verifier (kernel/bpf/verifier.c) that could
further simplify the code. Eduard (who wrote the code shown below)
probably would have a better idea.

On Mon, Oct 07, 2024 at 06:19:10AM GMT, Tejun Heo wrote:
> On Mon, Oct 07, 2024 at 11:28:27PM +0800, Kuan-Wei Chiu wrote:
> > This patch series adds KUnit tests for the union-find implementation
> > and optimizes the path compression in the uf_find() function to achieve
> > a lower tree height and improved efficiency. Additionally, it modifies
> > uf_union() to return a boolean value indicating whether a merge
> > occurred, enhancing the process of calculating the number of groups in
> > the cgroup cpuset.
> 
> I'm not necessarily against the patchset but this probably is becoming too
> much polishing for something which is only used by cpuset in a pretty cold
> path. It probably would be a good idea to concentrate on finding more use
> cases.

In BPF verifier we do the following to identify the outermost loop in a
BPF program.

	static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_state *st)
	{
		struct bpf_verifier_state *topmost = st->loop_entry, *old;
	
		while (topmost && topmost->loop_entry && topmost != topmost->loop_entry)
			topmost = topmost->loop_entry;

		while (st && st->loop_entry != topmost) {
			old = st->loop_entry;
			st->loop_entry = topmost;
			st = old;
		}
		return topmost;
	}
	
	static void update_loop_entry(struct bpf_verifier_state *cur, struct bpf_verifier_state *hdr)
	{
		struct bpf_verifier_state *cur1, *hdr1;
	
		cur1 = get_loop_entry(cur) ?: cur;
		hdr1 = get_loop_entry(hdr) ?: hdr;

		if (hdr1->branches && hdr1->dfs_depth <= cur1->dfs_depth) {
			cur->loop_entry = hdr;
			hdr->used_as_loop_entry = true;
		}
	}

Squinting a bit get_loop_entry() looks quite like uf_find() and
update_loop_entry() looks quite link uf_union(). So perhaps we could get
a straight-forward conversion here.

---

Another (comparatively worst) idea is to use it for tracking whether two
register has the same content (this is currently done with struct
bpf_reg_state.id).

	r0 = random();
	r1 = r0; /* r1 is the same as r0 */

However it doesn't seem like union-find would be as useful here, because
1. registers might later be reassigned
2. in addition to equivalence, BPF verifier also track whether content
of two register differs by some value (see sync_linked_regs()).

	r0 = random();
	r1 = r0 + 1; /* r1 differs r0 by 1 */

So maybe not here, at least I don't see how union-find can make things
simpler. But data structure and algorithm really isn't my strength and
I'm happy to be proven wrong.


Shung-Hsi

