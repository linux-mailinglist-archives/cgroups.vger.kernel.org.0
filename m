Return-Path: <cgroups+bounces-2170-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96AF88C8D3
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 17:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F601F667FC
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4097013C9A6;
	Tue, 26 Mar 2024 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3Ho0ZZ9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2C13C91A
	for <cgroups@vger.kernel.org>; Tue, 26 Mar 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469858; cv=none; b=Wz//pONr5EHX7+Ni8eiidZouKJu4zDfx4IOaSCpxquEghpmUUeFBgWygmsJds0L52Q/tyHz7RHtChcljvSsuf6DjGgwssG/VraS4AeEiux6en749vGRz3+fDTpNCTj/dEZfX++xVjpDQ3k8HYJ+XSYDb/rgUlTGshDu8BFZS/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469858; c=relaxed/simple;
	bh=zQKkQrzDagbafzUvsOneLsrUgkn6KJtkLouGtaJjx4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3BIBJLdgnnCXO/CIh/NLfZgu9CDbhQj8tYV6qVrpRqG0DpDW+RjsmXtQIVFj3hn+OB02LLzcOqNLxHlhmXPqg+TAqZKZs1A/siVtOV2lFLqmh2BMpTMu9uOVHkPeeJiWJeCoHFa33Lf+KdqWdTdEQ73upOmBScsXPf+xpHe8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3Ho0ZZ9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6ce174d45so4185577b3a.3
        for <cgroups@vger.kernel.org>; Tue, 26 Mar 2024 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711469856; x=1712074656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWIb3x6eOGk+I07iTuMtpicZ/pTpKNI41lwGHUlGVWM=;
        b=E3Ho0ZZ9sVRDNopBMVi8Xs/WwATSercDYmJ7F++TmmA224VcZFSiFyBujN/oM6VCAF
         gcxG2SW23omzF9LjyFZ+Q2XcgpDySbN/Mb8ipxQQ+4RHvFW8MnmtBLrqsOZV70VzND+c
         iLTLtUE2qTb9bJZuOfFJszlu98zMimS/jAf6wYwme7KzxtXLemq26CTJewxV9P57X682
         HjmlOlmWiIZtBX8AqPMytZFabeI1u1c8C/s29QAIMg4G4oaNN3tFOP4miaSlVKZrGVbr
         HNRe3tYkLnKhThWABoTN+4Ji3+s0Hkk4LL6xu94aWVhe/XtQpk5JEx1mlAaURj3iDfQT
         iWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711469856; x=1712074656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWIb3x6eOGk+I07iTuMtpicZ/pTpKNI41lwGHUlGVWM=;
        b=i1/i6A76C27OU40gC4YMEpydaa0JdZgsXzfwCP3ikIjApaC64qqlSFFqQxjPeZkRmr
         /6DZV0opP5qnnHXuvdpOr3Ub5TJSYxMLzAaaxOHeO4yvwjYTAhbSDIBLSOUPbvMesW82
         Huo36Vfa7sIxDpexetiTyvh0z9fJlZMaWGr56P91gQc1LaOHEPsfCEVzjrZBGdAsVCV/
         fjcQHt+zpn5oiyKxWmvT1Aj7jrxm9AfyLhgOz+SSm/aYp3AzVL577+xQbjB5wW5zdE6+
         ZBCdRZuzZ/DRRZD309w11RH6ugHq41H1lrwm9kA0I2Ql0Mk0/89INtRMYIxGT0jkuMTb
         SJeg==
X-Forwarded-Encrypted: i=1; AJvYcCWcJgrRaLVT6iu9vRrT5CJ8iQF2dWYldi3Huk+ZGSBcGJTsFcivCP1qTDDhZ9Cs48PARup9hxODYs3IhIXOGQLNVLcqjc9+5g==
X-Gm-Message-State: AOJu0YzWx9R5AHozKOyLOzdE3yny8EHTP4jqLvgqi2ChbjwtVmujWHdN
	oiMTmJ+gc2Ahl6yqiksyGjXaAEBf1zMVZeAMqzSa6KPkNOM63XiNjx8mlfDh
X-Google-Smtp-Source: AGHT+IFQFQ3d1x5aOZS6WWkcZcYaX+BI7o65udUx6ESjtlROsJi2pn3c6KZDIVVjzalDmoq1PP54fg==
X-Received: by 2002:a05:6a20:77a5:b0:1a3:66d8:d94d with SMTP id c37-20020a056a2077a500b001a366d8d94dmr7448878pzg.60.1711469855604;
        Tue, 26 Mar 2024 09:17:35 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:29ff])
        by smtp.gmail.com with ESMTPSA id gx3-20020a056a001e0300b006e6b4419ef0sm6126729pfb.89.2024.03.26.09.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:17:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 26 Mar 2024 06:17:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Petr Malat <oss@malat.biz>, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Make cpuset.cpus.effective independent of
 cpuset.cpus
Message-ID: <ZgL1HRiMcDcZHisy@slm.duckdns.org>
References: <Zfynj56eDdCSdIxv@ntb.petris.klfree.czf>
 <20240321213945.1117641-1-oss@malat.biz>
 <ZgHarUDknkJyidia@slm.duckdns.org>
 <c700ec0d-9260-438f-a9c8-7d7c268e4ed3@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c700ec0d-9260-438f-a9c8-7d7c268e4ed3@redhat.com>

Hello,

On Tue, Mar 26, 2024 at 11:14:53AM -0400, Waiman Long wrote:
> On 3/25/24 16:12, Tejun Heo wrote:
> > On Thu, Mar 21, 2024 at 10:39:45PM +0100, Petr Malat wrote:
> > > Requiring cpuset.cpus.effective to be a subset of cpuset.cpus makes it
> > > hard to use as one is forced to configure cpuset.cpus of current and all
> > > ancestor cgroups, which requires a knowledge about all other units
> > > sharing the same cgroup subtree. Also, it doesn't allow using empty
> > > cpuset.cpus.
> > > 
> > > Do not require cpuset.cpus.effective to be a subset of cpuset.cpus and
> > > create remote cgroup only if cpuset.cpus is empty, to make it easier for
> > > the user to control which cgroup is being created.
> > > 
> > > Signed-off-by: Petr Malat <oss@malat.biz>
> > Waiman, what do you think?
> 
> I think it is possible to make cpuset.cpus.exclusive independent of
> cpuset.cpus. There are probably more places that need to be changed
> including the cgroup-v2.rst file.

I really like the idea of making this more easier to configure. It'd be
great if you could Petr so that this can land.

Thank you.

-- 
tejun

