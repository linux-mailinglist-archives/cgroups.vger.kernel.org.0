Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 075F213B58C
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2020 23:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgANW4G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 17:56:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40222 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgANW4F (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jan 2020 17:56:05 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so14329332otj.7
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2020 14:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipIhJjAH0mlgj9mgI3WhoNWssFh6GjBw0YOeerhZCcU=;
        b=BXtYSedeHXcXqhdhhWIbtaBy54tVxbI3e9loIGv5zhO5CDgbahYX7y+Orjx6CD4zCZ
         0VhZIf5F4aluPlRU7PpNhbbEGba3pmcWe+cL3CBi5DKya+w5q6G9eUjD6Y6LZi3IlJ3t
         DrJUFTIu5BCbGGqB1F/xwGxS7UBhnEduOl7KTKpELe4ehBWkmis+mzbELNb1lGuQU++3
         QqqpluWfbXgvT/3D7WUNnyrjmuuZFxOwFtqlIlsp5tc9+S7eipRPEcevYerqbyHWNTNb
         Hhqn87JV86nkgRWq1rMf/JsZJIoYLMVRDfzRbSZxDqafJRFy4Ttng/Rd5qCfuV8koCw1
         S2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipIhJjAH0mlgj9mgI3WhoNWssFh6GjBw0YOeerhZCcU=;
        b=mn8gETIDepuwflhWq5vnsR84Cmch7LT1tg7KLbrzt+UVm2nKZAbDrrWsChrnTaqpz5
         qIBbNlDgVLljBPKq3L9lwiLMW3OwwLQPKPPBJDplfTgwXL44eiaOubkW294hv4E6YDiB
         hY+EgeyLc5u6oOXXoV/JRc2/OVGnVUoX9TORCW9cwjojUZZmpn6HjKRODkCqof9dljFi
         ZzGVNEq27wJQGaMLSNaIW9NNI8kuy/z1EhvN+dJMF50dV+fiLROUUch8xGWAc1LfMLmi
         TJ0hofy6zEloh4jgjFMf5moj6wRCmcf0ipejc4TO8+hTMoG5XDvsMZiS46t26Vk4Vxok
         S1pw==
X-Gm-Message-State: APjAAAWGjMyrnjdHyUud5vrjF5Cu6olPM2sYacKpMeydmqTWLEcXgr/n
        bAR32yI+wTZARPeach1+ypN0NJ0QCtgURqjacmjXYQ==
X-Google-Smtp-Source: APXvYqyQmL6MY3CQ5veK4yvMgm0Vfzi0RP3qvYcRSIpcE0TmezTJR9GdGI42+n8t1PA73eDd8usJHxZikf9yyvXL7gA=
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr557782oto.355.1579042565055;
 Tue, 14 Jan 2020 14:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
 <20191217231615.164161-2-almasrymina@google.com> <0855cae0-872e-0727-aa7c-55051d8f0871@oracle.com>
In-Reply-To: <0855cae0-872e-0727-aa7c-55051d8f0871@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 14 Jan 2020 14:55:53 -0800
Message-ID: <CAHS8izNcZnJmWOoagAkDtgKj9JfOoW0xuSuMAhO3wh3A1x2Dqw@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 13, 2020 at 2:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > +extern void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
> > +                                         unsigned long nr_pages,
> > +                                         struct cgroup_subsys_state *css);
> > +
>
> Do we need a corresponding stub for the !CONFIG_CGROUP_HUGETLB case?
>

Not necessary AFAICT because the code is only called from code guarded
by CONFIG_CGROUP_HUGETLB.

Addressing comments from you and David in v10 shortly. Thanks for the review!
