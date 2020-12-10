Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472CF2D6C21
	for <lists+cgroups@lfdr.de>; Fri, 11 Dec 2020 01:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394430AbgLJXp2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Dec 2020 18:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394424AbgLJXpR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Dec 2020 18:45:17 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0B2C0613D6
        for <cgroups@vger.kernel.org>; Thu, 10 Dec 2020 15:44:37 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id c12so5334312pgm.4
        for <cgroups@vger.kernel.org>; Thu, 10 Dec 2020 15:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=g1SDPT6a/nyFvkH1HOjQQzabblTO3UWN2aLImo+cfxM=;
        b=b9JDy4JmEv/AHWcU0PvO6asgJykeWO4XV039dPaKEH7CcxQJFd2pK3NCB4vsUNDhn6
         GGR9tHvFnfoFo89JP+jG7TclK4/eoVQ2KutfTGDx97mrgbK+vddqNaNOBzxMCrcAcdDm
         m3aDwid4LKxuBUv7ule60TmAKuYb60Hw4IRYyipMRDOIz84lcAryoYdqZYTP2tqfU8Sj
         CVSbmYzX6giwyTTWrjK8MPbpyH2UpZjePDtxa2HBZOTo7cvTurCvgniHeSI/emF68M8R
         UVfQBwlEP18Q9i9iW44LwjF5mOSB5VuC0VaP5tbNnCH4myyap2C4/QXXZ+qefaUr/yt6
         dVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=g1SDPT6a/nyFvkH1HOjQQzabblTO3UWN2aLImo+cfxM=;
        b=HCtSIRsle8OFA/lu/R/TSg92/9JCBw7RaWwp0XEpr9s6Wr35TuqzBHDu1WSTZNkDQ1
         8811v1E6AyTDDbV7FK1K9exTiuCnIOzIZErKzGvW0YaZv7cWyItOiWhbnFU3lGMOv3hv
         ISGXQY4F3tacplSGdYoltp24o5d1k2tolq/SC5NHMJ4Tztvqm2JQ+tNmtVC0pEiBlO0t
         PXagTzNLwBUdWMEDUDsWXzJu6wwEzAQ1d8LbLw5cPemxkJE18HY85Mjiee64QOTUqHoz
         3B6mkLiWe+D+aWYQGVJm8wWClsnHBS2yiadw9MS+OAD5C4qJIvOL4+HhAgVdU/3Nw9Ew
         IXhw==
X-Gm-Message-State: AOAM533D4wr1B625nHFJs2NGizWOq2NrPbyZZqOzwwnj3ftaAmijQ2g8
        luxbg2FfL78UKGHuX6NGufullQ==
X-Google-Smtp-Source: ABdhPJys1uu7FVwYO4hbjffu3RIHA+ARy0okQqM9r8wqDKhwr//ncETBKoXEYPHvhSyqXh8AWyQ+vw==
X-Received: by 2002:a17:90a:d494:: with SMTP id s20mr10351423pju.178.1607643876956;
        Thu, 10 Dec 2020 15:44:36 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id z19sm7367692pfa.122.2020.12.10.15.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 15:44:36 -0800 (PST)
Date:   Thu, 10 Dec 2020 15:44:35 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
cc:     Tejun Heo <tj@kernel.org>, Vipin Sharma <vipinsh@google.com>,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, jon.grimm@amd.com,
        eric.vantassell@amd.com, pbonzini@redhat.com, seanjc@google.com,
        lizefan@huawei.com, hannes@cmpxchg.org, frankja@linux.ibm.com,
        corbet@lwn.net, joro@8bytes.org, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, gingell@google.com,
        dionnaglaze@google.com, kvm@vger.kernel.org, x86@kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 0/2] cgroup: KVM: New Encryption IDs cgroup
 controller
In-Reply-To: <4f7b9c3f-200e-6127-1d94-91dd9c917921@de.ibm.com>
Message-ID: <5f8d4cba-d3f-61c2-f97-fdb338fec9b8@google.com>
References: <20201209205413.3391139-1-vipinsh@google.com> <X9E6eZaIFDhzrqWO@mtj.duckdns.org> <4f7b9c3f-200e-6127-1d94-91dd9c917921@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1482994552-364622287-1607643875=:399992"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1482994552-364622287-1607643875=:399992
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 10 Dec 2020, Christian Borntraeger wrote:

> > * However, the boilerplate to usefulness ratio doesn't look too good and I
> >   wonder whether what we should do is adding a generic "misc" controller
> >   which can host this sort of static hierarchical counting. I'll think more
> >   on it.
> 
> We first dicussed to have
> encryption_ids.stat
> encryption_ids.max
> encryption_ids.current
> 
> and we added the sev in later, so that we can also have tdx, seid, sgx or whatever.
> Maybe also 2 or more things at the same time.
> 
> Right now this code has
> 
> encryption_ids.sev.stat
> encryption_ids.sev.max
> encryption_ids.sev.current
> 
> And it would be trivial to extend it to have
> encryption_ids.seid.stat
> encryption_ids.seid.max
> encryption_ids.seid.current
> on s390 instead (for our secure guests).
> 
> So in the end this is almost already a misc controller, the only thing that we
> need to change is the capability to also define things other than encryption.*.*
> And of course we would need to avoid adding lots of random garbage to such a thing.
> 
> But if you feel ok with the burden to keep things kind of organized a misc
> controller would certainly work for the encryption ID usecase as well. 
> So I would be fine with the thing as is or a misc controlĺer.
> 

Yeah, I think generalization of this would come in the form of either (1) 
the dumping ground of an actual "misc" controller, that you elude to, or 
(2) a kernel abstraction so you can spin up your own generic controller 
that has the {current, max, stat} support.  In the case of the latter, 
encryption IDs becomes a user of that abstraction.

Concern with a single misc controller would be that any subsystem that 
wants to use it has to exactly fit this support: current, max, stat, 
nothing more.  The moment a controller needs some additional support, and 
its controller is already implemented in previous kernel versionv as a 
part of "misc," we face a problem.

On the other hand, a kernel abstraction that provides just the basic 
{current, max, stat} support might be interesting if it can be extended by 
the subsystem instance using it.
--1482994552-364622287-1607643875=:399992--
