Return-Path: <cgroups+bounces-12365-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0854CBF770
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 19:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37C523011419
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE7F2EA159;
	Mon, 15 Dec 2025 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qDTmPg5e"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64F325734
	for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765824289; cv=none; b=Fztg8mPDXTQFOj5VQWRPLVzGOlcTYLhz+HibIKR7cjeyCJA6e8PGw5BNDwUkTQbxWs4cnmg495arcCJeY1NhstQYB/nNYp19sWzfrsCIAyf6rAlC33MjK4vGc/mr/rqeIbNUDAvzCkVU+2Uw6/ORw7VT9S79ah2VXIoD3HePJUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765824289; c=relaxed/simple;
	bh=REAq5tjJRsZusshgZalKpSQNwxNqFLlWs+RPKXamC2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghNVT8OqAspGy8sDRzjz9FX3XCyKwjNn9+/7co/g9AaNN7ZXfWspal3lwNh6m3HTICtCoIMSbgBtQrT1j0YfEhVuP5KhaQG4MulSnAa8RE3JaoxsqooNXYfQBkO+pduW4RzTWBaluzu9ZKgmpax45D/SJ4iqvRFpD/fpXAfxKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qDTmPg5e; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Dec 2025 10:44:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765824270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAiqOi8TZw1rLsOvihPpKeP29wCvEI8XhvAaGda/QfY=;
	b=qDTmPg5eAfzImsbkCVnJoL+ZWsGX7DVQAmkvf2J5lFgLf8K/vtsuohQG6Pn8rxzs6qVFmN
	ToqkuRf7vsk1wTj7ayQKmBGt4OJQv6qCeNMxQEeWCsZaYfGaoLpASp5OMHYMB5nVI/eQpv
	IrIN09eHo6UExBTzxmN3hl2Q1RK16uc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] cgroup: rstat: force flush on css exit
Message-ID: <imgjggr6py3746i3bclw6o6vwktchw5gtt2pylilvftc7dqr4a@ywvoxalg2xbi>
References: <20251204210600.2899011-1-shakeel.butt@linux.dev>
 <hjxarrg2jy6cyy5hptjjbkop76jmb6mjdcazlcyqe6nnaoo3l7@7amn6gdssmeg>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hjxarrg2jy6cyy5hptjjbkop76jmb6mjdcazlcyqe6nnaoo3l7@7amn6gdssmeg>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 08, 2025 at 07:35:30PM +0100, Michal Koutný wrote:
> Hi Shakeel.
> 
> On Thu, Dec 04, 2025 at 01:06:00PM -0800, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > Cuurently the rstat update side is lockless and transfers the css of
> > cgroup whose stats has been updated through lockless list (llist). There
> > is an expected race where rstat updater skips adding css to the llist
> > because it was already in the list but the flusher might not see those
> > updates done by the skipped updater.
> 
> Notice that there's css_rstat_flush() in
> css_free_rwork_fn()/css_rstat_exit().
> 
> > Usually the subsequent updater will take care of such situation but what
> > if the skipped updater was the last updater before the cgroup is removed
> > by the user. In that case stat updates by the skipped updater will be
> > lost. To avoid that let's always flush the stats of the offlined cgroup.
> 
> Are you sure here that this is the different cause of the loss than the
> other with unlocked cmpxchg you posted later?
> 

I didn't see any stats loss due to this specific case but I found this
on code inspection while debugging the other issue.

> > @@ -283,6 +283,16 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
> >  
> >  	css_process_update_tree(root->ss, cpu);
> >  
> > +	/*
> > +	 * We allow race between rstat updater and flusher which can cause a
> > +	 * scenario where the updater skips adding the css to the list but the
> > +	 * flusher might not see updater's updates. Usually the subsequent
> > +	 * updater would take care of that but what if that was the last updater
> > +	 * on that CPU before getting removed. Handle that scenario here.
> > +	 */
> > +	if (!css_is_online(root))
> > +		__css_process_update_tree(root, cpu);
> > +
> 
> I'm thinking about this approach:
> 
> @@ -482,6 +484,15 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
>         if (!css->rstat_cpu)
>                 return;
> 
> +       /*
> +        * We allow race between rstat updater and flusher which can cause a
> +        * scenario where the updater skips adding the css to the list but the
> +        * flusher might not see updater's updates. Usually the subsequent
> +        * updater would take care of that but what if that was the last updater
> +        * on that CPU before getting removed. Handle that scenario here.
> +        */
> +       for_each_possible_cpu(cpu)
> +               css_rstat_updated(css, cpu);
>         css_rstat_flush(css);
> 
>         /* sanity check */
> 
> because that moves the special treating from relatively commonn
> css_rstat_updated_list() to only cgroup_exit().
> 
> (I didn't check this wouldn't break anything.)

Yes I think this is much better. We just need to disable preemption for
the assert within css_rstat_updated().

