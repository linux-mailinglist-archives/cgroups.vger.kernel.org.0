Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB68139C58
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2020 23:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgAMWVp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jan 2020 17:21:45 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36531 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWVp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jan 2020 17:21:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id m2so5723262otq.3
        for <cgroups@vger.kernel.org>; Mon, 13 Jan 2020 14:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ex3UFTMAEfhKx0guG0nwsJE0zOFUmspUTiiCdQZAYOo=;
        b=AZkS3aHZwBxsqylTsn1eEWpbfT0deg5vrOTs7LiyGB8g1lnK6FH2+UfYXBWvkY6ULv
         L2AahUncm3u08u2KnFq3IkcZNVLL+0q4Df/VS2nMgtdTEfhMV6UmkKoHEo30LFduORFW
         lNtWDDlPGuB18xsIfzirjOzb5FUEr8JVFbQ9lixTPZk9w8y2vYfwtQWfryXPkGPPJmEo
         tw1PmN8C9ibxP8UQDb/8CkVIA+vS9SZrs1AqtZyUwsA44pNP5dS4Vm06VWqn+YiWccoj
         7cM9PqJcK+T1kfuzzQlB+nt4mJ/rZmLAEFfmiWh12bHooq+Vhe2YKTYhcZvmM4l2p4UK
         Lc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ex3UFTMAEfhKx0guG0nwsJE0zOFUmspUTiiCdQZAYOo=;
        b=JKJDHKmrtD4bEdTfIkuzEM1BIFARbkl8yZtZb5bz/zaVdyENeAjhfL3UE6t8nMei+z
         2X53W7O7eaU0t+d9QQZbZQaPjHOuvIFisl/+RZboxCyhvFLZcxdhvx2/IBaiBC/ahRYz
         VMk/jukJwCcEJhPwnJyA3e3rEfD7NgbJSBaYW1WFOPyo8O59brS5a+5Y1bwkPxrffd/0
         V8ejFd9ZBAVsa+2j3t5zhDoS+pqPfTVHwSyhXaaZSQ/oqLbOax8Fyvc95v/J2dGAfmQ1
         oHATKHzFfIlpHtngDCarZBxwMCCg/haL3AXHL+czbKXUSAi656PQOgmsfQeMuOxNZte7
         9mUw==
X-Gm-Message-State: APjAAAXySYDdx+kbsRQf3zUoP95BHZWlX2uD7jeTuEBYYL6HZHSe/q6l
        i6TxeugJ15FisT2Cq8n6ZJOhbV0Aqnh97jrTwZUF2A==
X-Google-Smtp-Source: APXvYqyrwZQq75+I2BdkZCiafYfDDHWMS1tOXED+Q+CkQ89ZkgEcOJ+i4XsDk7VSWnoOQlqxRkrnw6Hl75zqF784lYs=
X-Received: by 2002:a9d:2c68:: with SMTP id f95mr15033850otb.33.1578954104459;
 Mon, 13 Jan 2020 14:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
 <817e2c4b-4c72-09f9-22ea-bbaf97584161@oracle.com> <CAHS8izNs24KOaRuQkVUuZZUh42rvkyBXJEJYrHNf9bLFnZEXCg@mail.gmail.com>
 <a78595a8-448c-14bb-a54b-9be685f36388@oracle.com>
In-Reply-To: <a78595a8-448c-14bb-a54b-9be685f36388@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 13 Jan 2020 14:21:33 -0800
Message-ID: <CAHS8izMT2vNASsR2H+3-4XN=+EkAEpS-LJ_UouaAa7iUfbLBhQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> >> On 12/17/19 3:16 PM, Mina Almasry wrote:
> >
> > The design we went with based on previous discussions is as follows:
> > hugetlb pages faulted without a prior reservation get accounted at
> > fault time, rather than reservation time, and if the fault causes the
> > counter to cross the limit, the charge fails, hence the fault fails,
> > hence the process gets sigbus'd.
>
> Ok, sorry I did not recall the design discussion.
>

No worries! It has indeed been a while since that discussion.

> > This means that one counter I'm adding here can cover both use cases:
> > if the userspace uses MAP_NORESERVE, then their memory is accounted at
> > fault time and they may get sigbus'd.
>
> Let's make sure this is clearly documented.  Someone could be surprised
> if their application not using reserves gets a SIGBUS because there is a
> reserve limit.

I have some stuff on that already in the docs patch, but I'll beef
that section up to ensure there is no confusion.
