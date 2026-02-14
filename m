Return-Path: <cgroups+bounces-13958-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INAUADHqkGkfdwEAu9opvQ
	(envelope-from <cgroups+bounces-13958-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 22:33:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB0713D9FF
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 22:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28425300FB6D
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 21:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003533126DA;
	Sat, 14 Feb 2026 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvpNyn2v"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C967311C05
	for <cgroups@vger.kernel.org>; Sat, 14 Feb 2026 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104768; cv=none; b=ioI5MqBDi6yUNSKIdDnrdY1ehMv9fzfC92Ym1QcJpZtG/VRrTma1aOk1t+rUPEKftP1hbGkawNna48t3jIlTzuGwfxCu1VjYXUYx0gOY89dujKA2keQNcfzyq9FARZSavlQkUCk5QIrbfQoQ3uT0RbqKNXZVkCmsBOO5bQ8qs/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104768; c=relaxed/simple;
	bh=Z5eV5vcZqxda2QUz/eYFD+gmiRF8BSY0g2dspxMBWMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=VtIYwSKcQDxBDcJJjj0XL2EUAfJXxBG6z66wIL5dDhGaEGwbRzw024y9YEPjGSf8fkMbNYP+1tX0TP7rEM8mieuelW6mzbViGafgBU0JTiRwPH1GDMMODrHjvqfe0k3GxvIyPw24e24FBaeTpwCSMpai+fHkgm4r26tqC9GaMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvpNyn2v; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-480706554beso19283065e9.1
        for <cgroups@vger.kernel.org>; Sat, 14 Feb 2026 13:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771104766; x=1771709566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rz00tC8xFfhwICo16BoBKz05b7In7aurUZExr5lcT2s=;
        b=LvpNyn2vLEVgNlmf36dWwusvFXkX9iZScsbzJah2nQDe8Mz2N3HxaLonJGpKAvHMA/
         w5kAzVnUFVTmfTxTey/wMsyq+oXkXzmD+yfi9b/OvxzjzNAQ+52K5594e9nD0WS2/1h9
         AUFt/xorVA8lBPH2MpQrHmlviXenwSL1cR0uOEAD3Gp8orVw2uH1a5k7FjAsBn4karlY
         rlK+HmMh2TyLNgVWB5o0vYPLnP4cpbnTHne6KWGGCAO1eoqDfSwvS7xQAjbw0qYSGWWr
         BCc6T8+QQsAjssLqWIzxnp72Lo/4lSjsGz3ZWV5aqTxzCxgBqTe+rAvntK+sX+xhheo9
         9N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771104766; x=1771709566;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rz00tC8xFfhwICo16BoBKz05b7In7aurUZExr5lcT2s=;
        b=o4arOil4Yr2JY6b5WeigpMZr8sod414WjoKkiWZe7VbD4Esx/wnHJRh39Gm5iyXWPy
         0LgjPz7rHkdclWsjENELqBhaazHIcOdERiYemSgBmc+7jUruAWL2ur/8GrESG0GgWr9B
         RCluBuGheQZXa0ZBVWCGq6/1AFsaNCshhR1geBdXzz+yZFre0/rMGJ0cDzvzkMzYiqDA
         yTz01Y2m5mSfKeO/XYOLMCZEofTYXOC/Ltkf6a/AZ7wULf1W2MfdOGTOIa8AARaZpzuw
         iJexKFBdi8LKxaqz00gDIhxBN04/LMGnJiN08kyC8Lng3xjNalkonPifhpnOiV7KXjYD
         Ykzg==
X-Forwarded-Encrypted: i=1; AJvYcCXAkWIpxElLCqoUMsvVN6rLEndchxIoZY15EtjSKhHSZUqsmlzPoJ2HzwWIkg5MuwVQ+fl/+LVA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/j7CCo47lWDvMj64XZqpezYxMlPKIXKkiFYnaj2Lif/VRYHm
	yXJ0xKr7I3PAm93e+Dp1gZRuITCRS9fjoMbSVIl2r/qAclIs1KkUiaN4
X-Gm-Gg: AZuq6aKP3F5d31bZzxKn6CeLuW6Wg+xRUxiCPlGBwLllbtREBxJiWJCoE+8ZcF5M5f8
	MKmUYHKUKI2k8dUgS8KMgSFF1FOb3j3kvVDV4Lwt/8qwpNU4z/M5zv236m/7DCiHDWT6L615QwR
	7uybMgg48OL5+9MRrAbgWvZD4gm/ctdKAx6Nxd2ycPHWTsAKFNXluT7r/dvLVIDGEJT4ZDRLAh6
	+hI1Ldc8lzjFRdT+FLwshLVA2A+kdJ6RpXe6WETKL15phvAaYFiOACMwC+TT2hoWA+NM7v/qDTv
	8tZxh42+R2CKpTg8Jp/0rM0J27QDVsb8OM9mcWFJTIqpI0bNTC7Gr4ZPsm7q27qe10BlLzex+Wa
	oVYo6Nwr36tgVvA3h6wIuesQEAmw2hgYDSoW84BZEmpORza6MF643WxBu/66IolyKdcgB5k7HbL
	9qYiZyuPPvgcKGV2P1xH9Cbq7Z/e88f5ab1H7kQ6PeszuR6Q==
X-Received: by 2002:a05:600c:1d0b:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-48379be820fmr59932915e9.17.1771104765392;
        Sat, 14 Feb 2026 13:32:45 -0800 (PST)
Received: from WindFlash.powerhub ([2a0a:ef40:1b2a:fa01:9944:6a8c:dc37:eba5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d994670sm238736745e9.4.2026.02.14.13.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 13:32:44 -0800 (PST)
From: Leonardo Bras <leobras.c@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 1/4] Introducing qpw_lock() and per-cpu queue & flush work
Date: Sat, 14 Feb 2026 18:32:30 -0300
Message-ID: <aZDp7thqWGHfs116@WindFlash>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aYxxXrG1UVvHUGHP@tpad>
References: <20260206143430.021026873@redhat.com> <20260206143741.525190180@redhat.com> <aYaEZGImn7qayP12@WindFlash> <aYxxXrG1UVvHUGHP@tpad>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13958-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leobrasc@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,linux.com,google.com,lge.com,suse.cz,redhat.com,linutronix.de];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEB0713D9FF
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 09:09:02AM -0300, Marcelo Tosatti wrote:
> Hi Leonardo,
> 
> On Fri, Feb 06, 2026 at 09:16:36PM -0300, Leonardo Bras wrote:
> > > ===================================================================
> > > --- slab.orig/MAINTAINERS
> > > +++ slab/MAINTAINERS
> > > @@ -21291,6 +21291,12 @@ F:	Documentation/networking/device_drive
> > >  F:	drivers/bus/fsl-mc/
> > >  F:	include/uapi/linux/fsl_mc.h
> > >  
> > > +QPW
> > > +M:	Leonardo Bras <leobras@redhat.com>
> > 
> > Thanks for keeping that up :)
> > Could you please change this line to 
> > 
> > +M:	Leonardo Bras <leobras.c@gmail.com>
> > 
> > As I don't have access to Red Hat's mail anymore.
> > The signoffs on each commit should be fine to keep :)
> 
> Done.
> 
> > 
> > > +S:	Supported
> > > +F:	include/linux/qpw.h
> > > +F:	kernel/qpw.c
> > > +
> > 
> > Should we also add the Documentation file as well?
> > 
> > +F:	Documentation/locking/qpwlocks.rst
> 
> Done.
> 
> > > +The queue work related functions (analogous to queue_work_on and flush_work) are:
> > > +queue_percpu_work_on and flush_percpu_work.
> > > +
> > > +The behaviour of the QPW functions is as follows:
> > > +
> > > +* !CONFIG_PREEMPT_RT and !CONFIG_QPW (or CONFIG_QPW and qpw=off kernel
> > 
> > I don't think PREEMPT_RT is needed here (maybe it was copied from the 
> > previous QPW version which was dependent on PREEMPT_RT?)
> 
> Ah, OK, my bad. Well, shouldnt CONFIG_PREEMPT_RT select CONFIG_QPW and
> CONFIG_QPW_DEFAULT=y ?

Oh, I sure think it should, even if not doing so at the current patchset.

But my point in above comment is that even if it did, there was no need to 
mention !RT and !QPW, as RT would select QPW, so you only need to mention 
QPW :)

Before QPW having it's own CONFIG_ I was using RT to compile this in, so 
maybe that's why the previous version of the cover letter mentioned it. :\

Thanks!
Leo

