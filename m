Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38DB4FA57A
	for <lists+cgroups@lfdr.de>; Sat,  9 Apr 2022 08:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbiDIGqI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 9 Apr 2022 02:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240156AbiDIGqG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 9 Apr 2022 02:46:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A17B6D31
        for <cgroups@vger.kernel.org>; Fri,  8 Apr 2022 23:44:00 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 32so7509795pgl.4
        for <cgroups@vger.kernel.org>; Fri, 08 Apr 2022 23:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KIbEhpDOtCyioS8BZF5p0mGW/6SLKhNyk9CSQ+cWmo=;
        b=mJomCgJeV+RXmlPTrKz6qrQhrHm7UDKRrcrKS4fB3ekDBuMvYloc6N3zmoewCRpve5
         5wL2KDqW8Z+tm6tNzomwdJaRht0Ve91sWusE4dVKDHUDO7qYsjj+FJxjENUtyF7aeBAn
         dlxb86l3upJFsQhUVQzQHMwAnzbOq3hpu68G8h/vPyJhHFbsDHrlvpzXBgmB8YrMsUU5
         vEnxIy4If3++IMbF512A0INdexqm6swj5Y83/EA90VybgBNxHF6AGuIGFQIKy/ogAVrY
         Fn7I8qbZ/6vMDoiFS2le7qfO1qviRbm+GcB25jK+buDGEz4Q8WoecYXCA5GlPJ+0QAlK
         9Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KIbEhpDOtCyioS8BZF5p0mGW/6SLKhNyk9CSQ+cWmo=;
        b=tL11bqV/xcwmwDvUaMTJAExsB8Kyqg4EAc5UKU5RdCP5oX/8JMILsNpCLcSCUYKSVt
         K5GbmXFlR8c4klbpaf+CmngCTdfFaBZCjLGuwLhKX8vsSvdd1aqkTwzHtAkGdORLXYLo
         ve7Qttskb7b2Lh5QUXI/mV+k/YjZNpnfoiT8sFEd1ehTyrX+/ocZ+5r3kxOL2NH6EtJ5
         LxgbwdQDvjImRanEnTLteOB11eJ83kgVpOLGvN6+gm6QFrrNtV7BDfHZWoeTnTUsgzXM
         1ixWW9JxlNXJKHpQ3IIIDdos8IinD1GcXlJ5g2evgKbhz+DZnB1CXPgr+2/UadTltIr8
         uoqA==
X-Gm-Message-State: AOAM533N2DepXLymU45rjW/Qa6kVEMhUsxP4GX4h6ubyUDuMU7loUZ/a
        2zy72r87k1xTxNIQ86voT3q2ngWzsrH4PYI5MOvCQQ==
X-Google-Smtp-Source: ABdhPJxoI+Rt3FuHlytPnMV9pwghZ6eRumL6W/khQzhcnTwilPXXMAY9cLvkEbBH/0UBAvxjMbxqY66yaPmjd4OXrpc=
X-Received: by 2002:a63:3e8d:0:b0:398:5222:3a3 with SMTP id
 l135-20020a633e8d000000b00398522203a3mr18742608pga.561.1649486639371; Fri, 08
 Apr 2022 23:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220408045743.1432968-1-yosryahmed@google.com>
 <20220408045743.1432968-3-yosryahmed@google.com> <CAJD7tkb6VJt=pfqnW11r6S7A0r2Vh85a3YZaVso-qyiCM06nDQ@mail.gmail.com>
 <YlDlCRSyR9xNW5dJ@carbon.dhcp.thefacebook.com>
In-Reply-To: <YlDlCRSyR9xNW5dJ@carbon.dhcp.thefacebook.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 8 Apr 2022 23:43:23 -0700
Message-ID: <CAJD7tkbiLQ8XV89yKDzJ467A7+=xvRMPw3pYwt+0gSnbwqBtVA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] selftests: cgroup: return the errno of write() in
 cg_write() on failure
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 8, 2022 at 6:44 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Fri, Apr 08, 2022 at 06:21:55PM -0700, Yosry Ahmed wrote:
> > On Thu, Apr 7, 2022 at 9:57 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > Currently, cg_write() returns 0 on success and -1 on failure. Modify it
> > > to return the errno of write() syscall when write() fails.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >  tools/testing/selftests/cgroup/cgroup_util.c | 32 +++++++++++---------
> > >  1 file changed, 17 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> > > index dbaa7aabbb4a..3b6bb09985fa 100644
> > > --- a/tools/testing/selftests/cgroup/cgroup_util.c
> > > +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> > > @@ -38,23 +38,23 @@ static ssize_t read_text(const char *path, char *buf, size_t max_len)
> > >         return len;
> > >  }
> > >
> > > -static ssize_t write_text(const char *path, char *buf, ssize_t len)
> > > +/*
> > > + * Returns:
> > > + *     success -> 0
> > > + *     open() failure -> -1
> > > + *     write() failure -> errno
> > > + */
> > > +static int write_text(const char *path, char *buf, ssize_t len)
> > >  {
> > > -       int fd;
> > > +       int fd, ret;
> > >
> > >         fd = open(path, O_WRONLY | O_APPEND);
> > >         if (fd < 0)
> > >                 return fd;
> > >
> > > -       len = write(fd, buf, len);
> > > -       if (len < 0) {
> > > -               close(fd);
> > > -               return len;
> > > -       }
> > > -
> > > +       ret = write(fd, buf, len) < 0 ? errno : 0;
> > >         close(fd);
> > > -
> > > -       return len;
> > > +       return ret;
> > >  }
> > >
> > >  char *cg_name(const char *root, const char *name)
> > > @@ -177,17 +177,19 @@ long cg_read_lc(const char *cgroup, const char *control)
> > >         return cnt;
> > >  }
> > >
> > > +/*
> > > + * Returns:
> > > + *     success -> 0
> > > + *     open() failure -> -1
> > > + *     write() failure -> errno
> > > + */
> > >  int cg_write(const char *cgroup, const char *control, char *buf)
> > >  {
> > >         char path[PATH_MAX];
> > >         ssize_t len = strlen(buf);
> > >
> > >         snprintf(path, sizeof(path), "%s/%s", cgroup, control);
> > > -
> > > -       if (write_text(path, buf, len) == len)
> > > -               return 0;
> > > -
> > > -       return -1;
> > > +       return write_text(path, buf, len);
> > >  }
> >
> > I have changed this in v4 to a cleaner implementation that either
> > returns 0 on success or -errno on failure. I also made sure to check
> > that the full buffer was being written, and updated cg_read() as well
> > for the interface to be consistent.
> >
> > Will send out once the discussion on patch 1 in v3 reaches a consensus.
>
> Ok, sounds good, please feel free to add my
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> for the whole series. It looks really nice and ready for merging upstream to me.
>
> Thanks!

Thanks a lot for reviewing it! I would appreciate it if you still took
a look at the v4 version of this patch when I send it (probably early
next week) as it's significantly different and includes changes to
cg_read() and read_text() as well.
