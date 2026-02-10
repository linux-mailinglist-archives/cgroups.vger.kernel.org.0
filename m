Return-Path: <cgroups+bounces-13846-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ6dD3O0i2m1YwAAu9opvQ
	(envelope-from <cgroups+bounces-13846-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 23:42:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8563811FCA9
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 23:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A67A6302592A
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 22:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9E3329C67;
	Tue, 10 Feb 2026 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4Cp5gD3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CABE126C03;
	Tue, 10 Feb 2026 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770763355; cv=none; b=GNPf/u/hhAay7VI7ARZd6ghrBaB+o0HXmORZheZsY9omkiVZYbu9k+JWkcBtkMAiYiJn5QRCrRYA2Bjax/slNrNi7eChMCnBKAOtVVkDjes9yUHtV6pYyufd1b+WizJOLflxcLQxSBK81PNPEwfmUrrrTKXwZ+H2Kgp/1ESm4UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770763355; c=relaxed/simple;
	bh=jIDXxxlEhxAE8fhU+GKIjrYEkfQF/0thbeDgyVF5erg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fe+xqFsYhMh+221eDarrGLjdf9Ak3J/tmmMzd3874jU0cEDSk+l1SeqXlHIMvf54phlJMxeo898HvBHkIGi3LmoyBsNkLrWQYH/BnZHY2f3wfL3cJ92Vi4PvkbOfZkbZeDU1CTv2VOKWYo2Atgiw89CT1eeO68PXwBI8sLZeQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4Cp5gD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F884C116C6;
	Tue, 10 Feb 2026 22:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770763355;
	bh=jIDXxxlEhxAE8fhU+GKIjrYEkfQF/0thbeDgyVF5erg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4Cp5gD3dW7Bm10R0U9RqpGZKpQVnJUvykyHaDQHhdnDzQaKeh+p0ktMjUdBdlN1D
	 SJ2dMMoOUwEhVnR/VtzX+rZW8iWeQQ7yiCxJdNukZdUPrC2tdIiUUxd/XsnZ5giFsy
	 l8Gosn/XMBIm7EeYcZgE4J1gPajWoVDUDR/DW/3PemdG2kT+mMYS0V20FDWnAJFQFG
	 18RkpeCtDdf2eWtjg5+m0kavzHOWD/jh3m66rsrjYWXdtaj960m5Thq6GG2l7J5UtY
	 Zcuq0dVB8S0nTEoZV6szql8DPjnsu0A8QzVMoWGXcJ8sqAM0yNxJZJccZ/2sM4aH7v
	 U6WMZo1dIvfmQ==
Date: Tue, 10 Feb 2026 12:42:33 -1000
From: Tejun Heo <tj@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: gregkh@linuxfoundation.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file
 deletion
Message-ID: <aYu0WZ-xCZr-bmsq@slm.duckdns.org>
References: <20260210003801.2834976-1-tjmercier@google.com>
 <20260210003801.2834976-3-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210003801.2834976-3-tjmercier@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-13846-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 8563811FCA9
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 04:38:00PM -0800, T.J. Mercier wrote:
...
>  static void __kernfs_remove(struct kernfs_node *kn)
>  {
>  	struct kernfs_node *pos, *parent;
> @@ -1520,6 +1538,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
>  			struct kernfs_iattrs *ps_iattr =
>  				parent ? parent->iattr : NULL;
>  
> +			if (kernfs_type(kn) == KERNFS_FILE)

kernfs_type(pos)?

> +				kernfs_notify_file_deleted(pos);
> +
...
> -static void kernfs_notify_workfn(struct work_struct *work)
> +static int fsnotify_self_event(int event)
> +{
> +	if (event == FS_DELETE)
> +		return FS_DELETE_SELF;
> +
> +	return event;
> +}
> +
> +void kernfs_notify_workfn(struct work_struct *work)
>  {
>  	struct kernfs_node *kn;
>  	struct kernfs_super_info *info;
>  	struct kernfs_root *root;
>  	u32 notify_event;
> +	u32 self_event;
>  repeat:
>  	/* pop one off the notify_list */
>  	spin_lock_irq(&kernfs_notify_lock);
> @@ -929,6 +938,8 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  	kn->attr.notify_event = 0;
>  	spin_unlock_irq(&kernfs_notify_lock);
>  
> +	self_event = fsnotify_self_event(notify_event);

Maybe just inline the conversion?

Thanks.

-- 
tejun

