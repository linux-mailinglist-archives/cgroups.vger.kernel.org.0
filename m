Return-Path: <cgroups+bounces-14137-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIvEIpganGkZ/wMAu9opvQ
	(envelope-from <cgroups+bounces-14137-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 10:15:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AA0173A85
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 10:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F65C301FD8F
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 09:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDFE34D907;
	Mon, 23 Feb 2026 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TvkUgvak"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E660205E25
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837875; cv=none; b=CEJZ6QT9Eh3t8zLBwiLFcdQ3kifwcNlL83J3DXJzKzDqg0S4KEUWxQoOK8lqn8wp/7SfK8jv3hcIcOGt3Ohei1pJE2ui2n6ndWt05ecJgryzer1TwKEAZvps+Rq3GE7C/UlpNAl4l0rhs2PP8yXIpXkkOXbKms+ITFDxtvyRc2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837875; c=relaxed/simple;
	bh=LORZo0OqfXIv0sBvk1bkOwYJ+YcFeKevt/s0WaS++LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RILlfIVPHe1v3eGVxRIBfxzGFrdFUgrUBpbXtZQwjlQw8Uu6L4ApD0TovSTvIVO21ErhU06TfS+vwuC4ibsu3le0mxZxFlRzbnRfrigX81PJvwuniPkY4tdlcPgx8VzrbLV1OBm8A0/Ymn/KkoaSuXv5eLVshmVM2hpW4Aq8CpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TvkUgvak; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso35296505e9.3
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 01:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771837873; x=1772442673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DC3YEg3VT9TOzY2WonmsTGNTfL3zmdr5vQ17Y5LSPTM=;
        b=TvkUgvakPIYtI0+QfM5CCZ6jo6JZF4nFCxkbhmnyBh0xFEcRphb08gBsCtkmp+BnGy
         JEI17aBrXmps0rxICD4eMJNRWgW7DoB0rrxFZHMOmjBKKJ8jgq9G7VgV2cNIjRiinUbT
         4XG5g5LhXB5BzqPxBQ0QwR8yoYh/qZn70wb4dvd4bjkdxMID8OTW4ca821tMSl0Q98u8
         EyWNfZUX4P8Qo4R3n5Sdlr/VVvjV+0jRDQLQ/6taC00D5Q0e10okuORc0YaAF/DBmHXj
         oTpA/o7tUCVUswKvvGCYu+PoRycMkjLg2dQ1r7xMC0Kzs+DS9l4Y1nwF38a/vOUy0tum
         iSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837873; x=1772442673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC3YEg3VT9TOzY2WonmsTGNTfL3zmdr5vQ17Y5LSPTM=;
        b=aRnJMbemMT7fGtOfxOHLSo/94s7XVTccZngn9NNbZhTaV9Gg4rk1WqHeMr/QsMnXeN
         rBtI9r19V9aOODcspoqGdtkkswvp7Nve+t1yHr+ZWErmT74M1TKMtZ1wpwt173rL8tvm
         J/sTFF93KnhFM+dmzmnVWfDGUfaQ24BMUgIeEw97V2FlEFniVBxiPWYmp4U2PkK4RfLt
         vV3sf9SwxEM+NRCCvZsDnadKp+xrT8wR/6wgrFA/GqmxFs9f2DCtdOotRuMCw3thZGoB
         F7zNSC6dB605eV06IDGaaZoL1NGvhpnWqo8Dyt7B4jqmjPJjC5f+GcbY2qFzhbnYjZuf
         b+8A==
X-Forwarded-Encrypted: i=1; AJvYcCUkZqHANHALGB68mR/s1ujbB74EiFiYXc5R1On6QsBMODfOMxWHSGoOpXjXR21M/F5lQQh3Mdpt@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5NyrbcnEErxSAi4B50b7l+bKUZ3QVKsR42ZtszEKwKDEvKlq
	rXDAcyJ2JMC5RPy+IIX5aw/bsK8U2fwhk+WGiD95LVRMRAIkt+K+sIAcc9Tc+tOVKnc=
X-Gm-Gg: AZuq6aJl18qYDjhUp6BFuOyedFXE6R8ZbNX9f0hSXlqmfHaYTNanKHhHotqWLDfsqYT
	hfNv/xjsrig/mXiqXcez0LNFhSVYv0ZRhzftPkMxcwgx8r5u9Ac6BUELooxOZ+6bPSGGdpjvsGu
	dBeWP3adoMJqENoPpMurySdwruZwOuSHM391RyTZU9vTO5xG50vrhEQKrUTng3CMnW16sJrHfDW
	Oep5IX1cNWwsYP6ETEFz/IHkoQxGr4VQni6b7JtSqcwwk7gprB9r/66lducuJnxLhi3feSU7r0x
	D8zIlqvoybdUI831JM14xcrZSKc5hgnV2xtXQHOaTC0/iqUuigONlLlJa+YzllPmGjIUu5TRe+O
	kXcEW5bhHuK1CJSYUGv/EPUNMJoRERVohEiCx4nh5XJJD6yFzufEbQJXNBWC3lpPtmwhYRm1dpH
	wQKtSZB5PbgbxlCwg1BFFxM6egRlbwbPU=
X-Received: by 2002:a05:600c:699b:b0:480:6941:d38b with SMTP id 5b1f17b1804b1-483a963baf7mr117526035e9.30.1771837872861;
        Mon, 23 Feb 2026 01:11:12 -0800 (PST)
Received: from localhost (109-81-84-7.rct.o2.cz. [109.81.84.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cab38dsm159620255e9.9.2026.02.23.01.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:11:12 -0800 (PST)
Date: Mon, 23 Feb 2026 10:11:11 +0100
From: Michal Hocko <mhocko@suse.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.com>, Leonardo Bras <leobras.c@gmail.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Message-ID: <aZwZrw_LTilXsPd4@tiehlicka>
References: <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
 <3f2b985a-2fb0-4d63-9dce-8a9cad8ce464@suse.com>
 <aZibbYH7yrDZlnJh@tpad>
 <a1c11a09-da88-4edd-9571-0f792b59e9c3@suse.com>
 <aZivpwJnIGKdAMYE@tpad>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZivpwJnIGKdAMYE@tpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14137-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:dkim,quantvps.com:url]
X-Rspamd-Queue-Id: A6AA0173A85
X-Rspamd-Action: no action

On Fri 20-02-26 16:01:59, Marcelo Tosatti wrote:
> On Fri, Feb 20, 2026 at 06:58:10PM +0100, Vlastimil Babka wrote:
[...]
> > >> So if we can assume that workloads on isolated cpus make syscalls only
> > >> rarely, and when they do they can tolerate them being slower, I think the
> > >> "avoid sheaves on isolated cpus" would be the best way here.
> > > 
> > > I am not sure its safe to assume that. Ask Gemini about isolcpus use
> > > cases and:
> > 
> > I don't think it's answering the question about syscalls. But didn't read
> > too closely given the nature of it.
> 
> People use isolcpus with all kinds of programs. 
> 
> > > For example, AF_XDP bypass uses system calls (and wants isolcpus):
> > > 
> > > https://www.quantvps.com/blog/kernel-bypass-in-hft?srsltid=AfmBOoryeSxuuZjzTJIC9O-Ag8x4gSwjs-V4Xukm2wQpGmwDJ6t4szuE
> > 
> > Didn't spot system calls mentioned TBH.
> 
> I don't see why you want to reduce performance of applications that 
> execute on isolcpus=, if you can avoid that.

If you can avoid that by making performance bad for everybody else then
then it seems safer to sacrifice those workloads that are much more
special - i.e. cpu isolation.
-- 
Michal Hocko
SUSE Labs

