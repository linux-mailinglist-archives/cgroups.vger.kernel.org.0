Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF12C28A5
	for <lists+cgroups@lfdr.de>; Tue, 24 Nov 2020 14:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbgKXNrl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Nov 2020 08:47:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388413AbgKXNrY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Nov 2020 08:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606225643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xffRRUEFdYVf/iIYdkTproP9RPvaJX79D3rZJfNU7HM=;
        b=TqzhQGB9Vb/AQAdHvdzY8e+9+goZ0Qaq9F/BZQG5IK1cSdT9webk308xxbIhLg8awnrf4/
        QfaVOhrZOcbi0glPYxso4CRwrSPQcZnUxAbhaJxdRsJzMXujV19ZpWkHsSoTgJaqokS2RW
        KvEjZo/3S9ujEtrr/rgEFwtJktVNN8w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-TCDh0WeiP66bib2WlOCLHg-1; Tue, 24 Nov 2020 08:47:19 -0500
X-MC-Unique: TCDh0WeiP66bib2WlOCLHg-1
Received: by mail-ed1-f72.google.com with SMTP id l24so7929958edt.16
        for <cgroups@vger.kernel.org>; Tue, 24 Nov 2020 05:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xffRRUEFdYVf/iIYdkTproP9RPvaJX79D3rZJfNU7HM=;
        b=Em9Q1Vu0IKa219y3//7HXoFi3R0sJ+Z47f/+TyI6Cwp4PfdpFYbJXdb5oIJ/yGyTmc
         5YY6rmZzgPAO7fcDDh0mQD4uIFlPz8wxizvtmOAVPujGFTdLR8WF2QscvkzWEOe62ovQ
         ViX+iSrRAKMQ7bzhx0I8SkZ9S9aewXpjKCgFQCTWBvXVzDjAgOKjiu1d1gllQQdxzTSc
         m1BOfRzueK0m3tzcA2QQPECfXptJkJvDKhKWccgsUZh202wrlrkpip2ERdmDa2F6B+V5
         d6cxT2ZOwwECGwU1mTxZIizXKS983IqUSevsG4S1wvHGeMm1YzEgn5oH3snypSB6l9UK
         B5qQ==
X-Gm-Message-State: AOAM530O2oDqt/hRopwL5uop6otfMbTZzAkQjG8EuYEwP4EzZFoH0iB/
        gID4L/0k2IZuDGQmm6SYjVqlos2A3IBNuB70HS+zqwrW1H+kpuPka5a9FzyBUmRln2JGZwZnLBA
        PA2liN/HGXXlxIeVj3PsMn850cno2eLth
X-Received: by 2002:aa7:cac2:: with SMTP id l2mr4062575edt.141.1606225638301;
        Tue, 24 Nov 2020 05:47:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqRJKaDCOU8o8lJUBpvIonCI4iSMmccpTsGPpfIOAUjWgIRZoULRAqw8LcNxkGji38m0SYjUfv9vLzN6m/Y+w=
X-Received: by 2002:aa7:cac2:: with SMTP id l2mr4062564edt.141.1606225638122;
 Tue, 24 Nov 2020 05:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20201124105836.713371-1-atomlin@redhat.com> <20201124112612.GV27488@dhcp22.suse.cz>
 <CANfR36hyrqXjk2tL03GzCk6rn6sCD7Sd811soBsZC3dHY0h9fQ@mail.gmail.com> <20201124133644.GA31550@dhcp22.suse.cz>
In-Reply-To: <20201124133644.GA31550@dhcp22.suse.cz>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Tue, 24 Nov 2020 13:47:07 +0000
Message-ID: <CANfR36hw8iSSszSt4sNh+ika3vTdXQnXHPLj5t2iLL=5-nzZZw@mail.gmail.com>
Subject: Re: [PATCH] memcg: add support to generate the total count of
 children from root
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 24 Nov 2020 at 13:36, Michal Hocko <mhocko@suse.com> wrote:

Michal,

> This like any other user visible interface would be a much easier sell
> if there was a clear usecase to justify it. I do not see anything
> controversial about exporting such a value but my general take is that
> we are only adding new interface when existing ones are insufficient. A
> performance might be a very good reason but that would really require to
> come with some real life numbers.

Fair enough and understood.

At this stage, I unfortunately do not have such supporting data. This was only
useful in an isolated situation. Having said this, I thought that the
aforementioned interface would be helpful to others, in particular, given the
known limitation.

Kind regards,
-- 
Aaron Tomlin

