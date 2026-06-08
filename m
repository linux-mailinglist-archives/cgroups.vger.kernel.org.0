Return-Path: <cgroups+bounces-16732-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2LAhF+vEJmotkQIAu9opvQ
	(envelope-from <cgroups+bounces-16732-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 15:34:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEA8656B04
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 15:34:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Pv0VI3Tc;
	dkim=pass header.d=redhat.com header.s=google header.b=q96AAsZ1;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16732-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16732-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 874F73032F52
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CA8376A17;
	Mon,  8 Jun 2026 13:31:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4D37B03E
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 13:31:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925485; cv=none; b=rxYkTd6SbXHKc3JrU+1lzkogx2JCkj011zBqkR/RQ3TFxbAkuK26Xpm9Lxf5Gf/Hk0Rd9mMO6ybecBYyWM2Du6X9Cuq9qNEjbXkbRAE2WL32RHwpRDdll9ArwvZklUMr8EXVLU+Zy6E989IV4HHh4JU7Hy7lYxf7ZCxdUQpibPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925485; c=relaxed/simple;
	bh=GwCuKLbifrVUjBrnmgsr5H16eGrctid/Y/EhKUyp1Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV3VeMsCUl7yMadiSn1DhJSQZcz1WZLbwWnAK+XqJnF0v8Gi0Gd6ZUreCZJosytFbuv1/TXuH0r6pExat60yTrZWh05B3zQHAqYnllREZ9Ea1JBBmJWprfGwZjgKC/GYeyfvwXQ0XfTj/Ojhmk0VdopjPiV39+qmWebD3HVd6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pv0VI3Tc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q96AAsZ1; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780925483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iewDQSsA13YrnQ4UInBbfMz/SjkA5BPlaeZcu83emSo=;
	b=Pv0VI3TcKvxXxnx/j1AduFzQwO1ELkBz61hV31CsEAFqPcnTz9LsbgkTkt86tE0LgGEA3S
	uURUBHEknufBYF4hlWsDRwRHz7q3VS3nA3+pIKovZxY1OANavDM8kCJFq9yJbIzV5Kfdhb
	+LGBbSVzJiX5a7p8L5GH3AmOt4lWKv0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-nydHYavyMWWMaA-z0BT7nw-1; Mon, 08 Jun 2026 09:31:15 -0400
X-MC-Unique: nydHYavyMWWMaA-z0BT7nw-1
X-Mimecast-MFC-AGG-ID: nydHYavyMWWMaA-z0BT7nw_1780925473
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915c364ae3bso339610985a.0
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780925473; x=1781530273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iewDQSsA13YrnQ4UInBbfMz/SjkA5BPlaeZcu83emSo=;
        b=q96AAsZ1AEJ0swnZM5+1RnEAZUHLO+ROaUJd4mwwD+1bnCakuoHyW2iFHODR+r/C06
         GpRc30XOpMale66H/QmLs0xIh3wd0NT99xa/91I7kCpCSmcfJPk1OHkjBhJ8WWj9l8eN
         Q7ujdrzrfmehq9h98B78VPJp5ioL1nZIkW9kia6iJLEYIBQSV4GJdOtl9HiQUB4q1cX7
         SGg8JRvzZkZqqbUkDLWOKFwyfxqrc9aEti7tQTjaKfSOi7Ehbk+hDeHWlsgGsVHXr1r7
         uP9hl+Jbv44fSbZbvHWS1/LD3Z1M7mSkO5gXZFx8UpDNOT5aD00ayOrzSz62Q7X/g3/R
         j1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925473; x=1781530273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iewDQSsA13YrnQ4UInBbfMz/SjkA5BPlaeZcu83emSo=;
        b=PSlTnUX+YBSnJDYOqNyz4voNEkd+FjWx2TNmwwCyMxLONQz+vGzB29jolAwV98IWUL
         /t8bJJH0MloBKdciSoSyAQOr3Xi7LFfylG0O9KenAxVjl7oOK+C+8fD2fPxDt0fcSaAk
         7TMIVmDqGCJoUuTebROGaC/dII4CIkD0ByMqlROR6VoaBEzC9StM8JApHEXhI19eD2Us
         9swASdHz43W6bNX4tANbFbAf0vxo+uZwiKWIxL4MryOszGrNrvbceScVh6LC+dT0R58x
         rlA/qB6wyoaBCg1mhEbo/YTXDNRsCmMIkVl1i92iPGRCvyhnbsRPtwbX9szySgYG5EcH
         qBCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ozPtBGqJIxE16Uj6e1V2MJncqL2pF2E3q+oIokLWJVnA8bvBBDOHZ6pbqSkq1cXlX3Vnrh07o@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ie7X8VpLFdj+3N6I1cuR5jNN+N49Df3slWqmUBZVZSNb/1MA
	LXZsxBozDszTTLy9upkpIuj6eYWvSVp1QLM4NcinqAEapEbx7UjMcpyitm+cS7TE9rn4ygubTYH
	9NAVQAYADcb2ALJbCBG43LhCbj+6yy4DLWIls/Plysnb1VaCFgBx23/UGQG0=
X-Gm-Gg: Acq92OH6nkunHHVZ9Q8awyRjSlBSNAHL/esgkiswmw2vGn9WmaJiu734LnOHNcvy7oV
	QjHnEIzQu7V5CwokSQw8dzB8waxOHQxYdSHYtEjnAOvtmWXAOXROvOMsQgV5fuou9yF0cYzOIam
	rkqq5cMMi2EbWp+XwI+wbTRDHOtKpCpo5kvbAKoisNgYiIoZ1MntbZUzXG3QIaz56H8RnDWvKcE
	29VSV5GMzcGsT99WJGhjN6x2nzLi8qMzjVBUZIoTIV2BnM3oNIKrMNmA8rupg+VgtWSBBku26Ri
	YLhYLmUzrdDzau82vi0pfI5acvRyhjWoPLgSQJ/L0Ejyda47y3XrPThcwe/RyOcjKoHnNBtpJYO
	HxAffyuu3uA7wX+1TcJJr7+t9CbSlb4uFwxpiPYFNUcnyNsVjqzTBYko7WsAvnetZmVX/nnEc2J
	Rt
X-Received: by 2002:a05:620a:4546:b0:915:cf88:1e3b with SMTP id af79cd13be357-915cf882096mr770201885a.47.1780925453570;
        Mon, 08 Jun 2026 06:30:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4546:b0:915:cf88:1e3b with SMTP id af79cd13be357-915cf882096mr769780685a.47.1780925431588;
        Mon, 08 Jun 2026 06:30:31 -0700 (PDT)
Received: from localhost (pool-100-17-17-231.bstnma.fios.verizon.net. [100.17.17.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a238f8esm1762107885a.15.2026.06.08.06.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:30:30 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:30:29 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Natalie Vock <natalie.vock@gmx.de>
Cc: Maarten Lankhorst <dev@lankhorst.se>, 
	Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
Message-ID: <aia9FfWlmRivZCQe@x1nano>
References: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
 <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16732-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:natalie.vock@gmx.de,m:dev@lankhorst.se,m:mripard@kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:aesteve@redhat.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,x1nano:mid,patchwork.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACEA8656B04

On Sat, Jun 06, 2026 at 06:31:53PM +0200, Natalie Vock wrote:
> On 6/6/26 00:44, Eric Chanudet wrote:
> > Accept only one "region value" pair entry for the dmem.max, dmem.min,
> > dmem.low files.>
> > This changes the UAPI that otherwise accepted multiple lines for setting
> > multiple entries in one write. No existing user is known to rely on
> > writing multiple regions in a single write.
> 
> Ugh, shoot.
> 
> For dmem.low specifically, there already are some userspace thingies
> floating around that may write more than one region/value pairs.
> 
> These thingies all depend on that one patchset for dmemcg protection that I
> should really get around to merging[1]. Since the userspace utilities depend
> on not-yet-merged patches, they sort of have to expect stuff changing under
> their belts, so I wouldn't really consider those users a blocker by
> necessity.
> 
> As I see it, we could go down one of two paths:
> 1. We go ahead with the patch as proposed, and I make sure that the users I
> know of adapt. Could be a bit icky wrt. "do not break userspace" rules, but
> since the already use non-merged UAPIs in one place, you can argue that
> these users kind of have to expect breakage.
> 2. We use the old handling allowing multiple lines for dmem.min and dmem.low
> only. This preserves compatibility but uglifies the code by quite a bit.
> 
> All things considered, I think I personally would prefer going with 1. and
> taking the patch as proposed and just having one codepath handling every
> limit file. Just highlighting this so we don't do it on accident.
> 
> [1] https://patchwork.freedesktop.org/series/163183/
> 
> Some more review comments inline.
> 
> > 
> > Processing multiple regions in dmemcg_limit_write() could quietly change
> > first limits before failing on a later one and returning an error to the
> > writer, with no indication some changes occurred.
> > 
> > Signed-off-by: Eric Chanudet <echanude@redhat.com>
> > ---
> > Follow up from discussions on a previous thread[1].
> > If Albert's series[2] lands, I can cleanup and prepare some kunits for
> > these as well.
> > [1] https://lore.kernel.org/all/158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se/
> > [2] https://lore.kernel.org/all/20260519-kunit_cgroups-v4-1-f6c2f498fae4@redhat.com/
> > ---
> >   kernel/cgroup/dmem.c | 70 +++++++++++++++++++---------------------------------
> >   1 file changed, 26 insertions(+), 44 deletions(-)
> > 
> > diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> > index 6430c7ce1e0372f59f1313163fb7630ce49ac1ef..113ee88e276296bccb4def546adf5cc175d7f0be 100644
> > --- a/kernel/cgroup/dmem.c
> > +++ b/kernel/cgroup/dmem.c
> > @@ -734,57 +734,39 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
> >   				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
> >   {
> >   	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
> > -	int err = 0;
> > -
> > -	while (buf && !err) {
> > -		struct dmem_cgroup_pool_state *pool = NULL;
> > -		char *options, *region_name;
> > -		struct dmem_cgroup_region *region;
> > -		u64 new_limit;
> > -
> > -		options = buf;
> > -		buf = strchr(buf, '\n');
> > -		if (buf)
> > -			*buf++ = '\0';
> > -
> > -		options = strstrip(options);
> > -
> > -		/* eat empty lines */
> > -		if (!options[0])
> > -			continue;
> > -
> > -		region_name = strsep(&options, " \t");
> > -		if (!region_name[0])
> > -			continue;
> > -
> > -		if (!options || !*options)
> > -			return -EINVAL;
> > +	struct dmem_cgroup_pool_state *pool;
> > +	struct dmem_cgroup_region *region;
> > +	char *region_name;
> > +	u64 new_limit;
> > +	int err;
> > -		rcu_read_lock();
> > -		region = dmemcg_get_region_by_name(region_name);
> > -		rcu_read_unlock();
> > +	buf = strstrip(buf);
> > +	region_name = strsep(&buf, " \t");
> > +	if (!region_name[0] || !buf)
> 
> If buf is NULL, isn't strsep(&buf, ...) also NULL? region_name[0] would
> therefore be a NULL pointer deref. Flipping the order of the logical or
> should be enough to prevent this.
> 

I can do a v2 with that today.

I added it if there are no delimiter found (e.g, if only the region name
is passed and strstrip() ate any trailing space). Although, buf can't be
NULL in the write callback iirc, it's either pre-allocated or
kmalloc'ed.

> > +		return -EINVAL;
> > -		if (!region)
> > -			return -EINVAL;
> > +	rcu_read_lock();
> > +	region = dmemcg_get_region_by_name(region_name);
> > +	rcu_read_unlock();
> > +	if (!region)
> > +		return -EINVAL;
> > -		err = dmemcg_parse_limit(options, &new_limit);
> > -		if (err < 0)
> > -			goto out_put;
> > +	buf = strstrip(buf);
> 
> Do we start allowing extra spaces between region and limit as well? Would
> also be fine by me, it doesn't break anything, just highlighting that it's a
> change in behavior. Should perhaps be documented in the commit message, too.
> 
> Also, you should be able to use skip_spaces() here for an equivalent result.
> I'm not strongly opinionated on either way, but using skip_spaces()
> indicates more clearly that this can only remove spaces at the start.

Same I can add to v2, I failed to notice it wasn't allowed in the
original logic.

Thank you for the review.
Best,

> 
> Best,
> Natalie
> 
> > +	err = dmemcg_parse_limit(buf, &new_limit);
> > +	if (err < 0)
> > +		goto out_put;
> > -		pool = get_cg_pool_unlocked(dmemcs, region);
> > -		if (IS_ERR(pool)) {
> > -			err = PTR_ERR(pool);
> > -			goto out_put;
> > -		}
> > +	pool = get_cg_pool_unlocked(dmemcs, region);
> > +	if (IS_ERR(pool)) {
> > +		err = PTR_ERR(pool);
> > +		goto out_put;
> > +	}
> > -		/* And commit */
> > -		apply(pool, new_limit);
> > -		dmemcg_pool_put(pool);
> > +	apply(pool, new_limit);
> > +	dmemcg_pool_put(pool);
> >   out_put:
> > -		kref_put(&region->ref, dmemcg_free_region);
> > -	}
> > -
> > +	kref_put(&region->ref, dmemcg_free_region);
> >   	return err ?: nbytes;
> >   }
> > 
> > ---
> > base-commit: 640c57d6ca1346a1c2363a3f473b405af979e046
> > change-id: 20260605-cgroup-dmem-write-single-region-9bf05b6d995d
> > 
> > Best regards,
> 

-- 
Eric Chanudet


