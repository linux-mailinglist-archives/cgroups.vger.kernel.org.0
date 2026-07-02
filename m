Return-Path: <cgroups+bounces-17434-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BwnoC4XdRWrLGAsAu9opvQ
	(envelope-from <cgroups+bounces-17434-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 05:39:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E77B6F34A8
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 05:39:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qa4hAJEy;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17434-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17434-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1654F3019FC9
	for <lists+cgroups@lfdr.de>; Thu,  2 Jul 2026 03:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7193375D5;
	Thu,  2 Jul 2026 03:39:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E7133A715
	for <cgroups@vger.kernel.org>; Thu,  2 Jul 2026 03:39:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782963583; cv=none; b=IUjfdDBcfbtRECdxkWT/aF/LpKIRX0rLSlcDHT82td3rS3dh6ZcmebiHromVSmdRq9egip17RUYmFATVTWO2ynC9rhCtNyngLYL8dBYk1q898KBybePtH0X+y0MxNkZ5fdjPqfnL8COEalk0b/xNmajrao9KseURhADN1ptGv98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782963583; c=relaxed/simple;
	bh=kSShOwgNt8IDVVQslIs1QEU/IBXXGiSnMdnup/QXhVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuNZMfUI+/CaT4S5bjTx2r5+wOlfTpDapKE6BTmY9t60z96x9zYzXlvH5ScarN/vn+O5FDhEt9rJoumr3FG6U/FjjL1WB9LBMvTvMw7xcariFCyLTOknPWBEcGAty0NwJr70sAabJgg9VuMUDs80h58MVevRsjZF0ty0hDg/Fqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qa4hAJEy; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37dedd62b90so144468a91.1
        for <cgroups@vger.kernel.org>; Wed, 01 Jul 2026 20:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782963580; x=1783568380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIEGBTVDaNYu4hR+EgvyT/hJz0vtGSFwLtKpw+9mfTU=;
        b=qa4hAJEynPQrLhUOImKdOXVEXmQvpaI2Np+eD4PAldsnMiE9rNr+y+5frB/IUO1zdi
         5tKKUTVRhS60fLiE5937zMfec1xfOTGkBBpreMSIF5BOqpKbt9m15jqYe5HHBxxeigzp
         8WAoGug+6eRos2g1eyJFqOA85ijHmKp9Tp3FoklHOBmRloB8P3Xww8DzS7HRhRXcrNu2
         NHu8Yc4GJ4YHKqL3ANP2YgUsYZLqVcL+ZQZkHIjRcLf1pX3P+Mj02rJMnUe9ChtaLoLZ
         1LbzjzP/LyGesTc+YHre0Lmf5lY9BF4ZbxkO2pjOWRj4fSvFprlIvy2oQzkOTtGaYBXZ
         HcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782963580; x=1783568380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uIEGBTVDaNYu4hR+EgvyT/hJz0vtGSFwLtKpw+9mfTU=;
        b=sDM5wqOk5Wh9O2S5XlLZp1aeVgKb0PzubMeG1SeMteQJvNUwJc7v/9lSFzgNce3kGj
         /WIyXbS2vVehZQXtBwOIzPGWFr80g12DCe4wTs1MkUjRW+yuGdXmQiWa/n9tVGXdWKmw
         Y1cV6nXKS2L6077qEmmKvemftbqTdHGRONH2kLqgAyrxvAfhGJ2DcWa0MsdrbbgpKfY5
         7asEK8BgkHDuH7Zjwh7avPiVVy5qMCq73dP57Wb/JFEuMBvkyZVev0HsNBh7RkuDm2iv
         mT1s7SUhJWCgU0IOVMM6QO2y1cXz293E6UcurMlysPU/fXqOQB29MieqkFRLGm+L2MA4
         Ko4g==
X-Forwarded-Encrypted: i=1; AHgh+RqvW11dQd2UXKObtqobqBam3+gEM+zdzd2+CQ6ZBvYe2/h84Xcrd9pj8+9I68fKUVsIjne8lBQy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqxgfc6ArF8QkRN2KKWbLBwAReTEHIH1kxtM4FKwwu7PtdcH9L
	poK296JIWyamB2pRNoUlfd6XTyYV3eE8AKTaGfeZoImZgXuMMKq2KcDm
X-Gm-Gg: AfdE7cmnDnMX9xvNYvvXRBm5Ov5+bInSoDR0Nls+/OlsAIlx80pxZEpMHBqzkR+vb3x
	wm9CyrVhcINyrudf/8FShRx+BJNiIBH32UEDVF7IES8p8hlUUmyYgILptOL60+eN15SgOCQ/sif
	OukGt24QY2fZ1Km8BPO0lr43PDOFgrahLMpwav01aiyI+LmkD/RrVnqSJNoaA3Gs/+iTz81BGtY
	lXfMyq2itIidicUYll4gmizZeWXCwyFYWPH2Yv7+5EXK29dRhzSEvf8KZIwJYLCyhVrXLMv6R0o
	k4yAOxoRoiCJ34kqjcFhvjFgUeNKYlsv41ipWpwC6Y9LoQDHO5PNgJ9Bjd/Zt1EFexNID9w51jP
	DG0udNsT+JtMK3EnzXYcA4euXrPttNmOmIg6PMhLrraeShkCjKWsdsvGicACcsx5BlofTNFyvAt
	OLO8je+Uw=
X-Received: by 2002:a17:90b:5827:b0:37f:9e21:91d9 with SMTP id 98e67ed59e1d1-380aa21afd1mr3930206a91.16.1782963579929;
        Wed, 01 Jul 2026 20:39:39 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380e165cf62sm252231a91.17.2026.07.01.20.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 20:39:39 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: Waiman Long <longman@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: Jing Wu <realwujing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of nohz_full and managed_irq CPUs
Date: Thu,  2 Jul 2026 11:39:33 +0800
Message-ID: <20260702033934.984512-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <fe35dd41-7068-4cf0-9ee9-eb9c12017b42@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com> <akUii2CyEi7SRid7@localhost.localdomain> <fe35dd41-7068-4cf0-9ee9-eb9c12017b42@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,chinatelecom.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17434-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:frederic@kernel.org,m:realwujing@gmail.com,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E77B6F34A8

On 7/1/26 14:56, Waiman Long wrote:
> On 7/1/26 10:22 AM, Frederic Weisbecker wrote:
> > > I know RCU support changing the nocb mask for fully offline CPUs, I
> > > will need to find out if it possible to do that for partially
> > > offline CPUs.
> > No because callbacks can still be enqueued at this stage. But we could
> > manage to make it work with CPUHP_AP_IDLE_DEAD.
>
> If we can only go as high as CPUHP_AP_IDLE_DEAD, we may as well go down
> all the way to CPUHP_OFFLINE [...] we may have to break RCU out from
> HK_TYPE_KERNEL_NOISE and add a cpuset control switch [...]

A data point from the DHM side that corroborates this.

Our RCU/nocb prototype toggled the NOCB state by fully offlining each
affected CPU, one at a time:

	remove_cpu(cpu);
	rcu_nocb_cpu_offload(cpu) / rcu_nocb_cpu_deoffload(cpu);
	add_cpu(cpu);

i.e. it went all the way to CPUHP_OFFLINE, which matches Frederic's
point that the nocb mask change needs the CPU at least at
CPUHP_AP_IDLE_DEAD - callbacks are still enqueued before that.  It worked
functionally, but it also confirmed the cost Waiman describes: each
remove_cpu() pays the stop_machine price, so doing this while another
isolated partition is running latency-sensitive work is disruptive.

We are reworking that code precisely because doing it asynchronously
raced with concurrent CPU hotplug (a TOCTOU on cpu_online() and the nocb
state), so +1 that this has to be serialized against hotplug the way
Thomas outlined.

So decoupling RCU from HK_TYPE_KERNEL_NOISE and gating the "pay the
stop_machine spike" behaviour behind an explicit cpuset switch sounds
right to us.  RCU seems to be the only kernel-noise type that needs to go
that deep; tick, managed_irq and the watchdog appear to only need the CPU
to cycle through the existing online-side callbacks, not a forced
IDLE_DEAD - please correct us if that is wrong.

On Frederic's idea of asking userspace to offline the target CPUs before
toggling isolation: that cleanly removes the kernel-internal offline for
the isolate direction.  How would you see the de-isolate direction - the
admin brings the CPU back online and the housekeeping/nocb masks are
recomputed in the online path?

Waiman, since you mentioned you have not started on RCU and it carries
the deepest hotplug constraints, we are happy to take the RCU/nocb
decoupling piece and build it on top of your CPU down/up primitives,
following Frederic's CPUHP_AP_IDLE_DEAD guidance.  That keeps the
subsystem split clean and avoids duplicating your tick/irq work.

Thanks,
Jing Wu
Qiliang Yuan

