Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3894BBDAB
	for <lists+cgroups@lfdr.de>; Fri, 18 Feb 2022 17:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiBRQjo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Feb 2022 11:39:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbiBRQjn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Feb 2022 11:39:43 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90922B04B3
        for <cgroups@vger.kernel.org>; Fri, 18 Feb 2022 08:39:25 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id bn33so5122602ljb.6
        for <cgroups@vger.kernel.org>; Fri, 18 Feb 2022 08:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZsaJ/52U7cZLmE6ctPyXK8XUe33/stjG8THMIu6wVGU=;
        b=RlQ/Wx7QFlwknPTQbVvjrxcl4E9RzQ2/VKYDGLGK3WW8txbJIsltBAIVTI5JcNwXK0
         iC5zOzJsOU6rKE+QZ7O3I3HYWBGzvq/2tdD+IyWDNJpEg3GbHdCCabSJ/s/CR9YEZmHX
         byRKHpIwAmFwny9oi9nwOwjo0yVzfG8ECrC0xIvtON8BR5FzQvZgQXw+Y8IO7vrRrDxp
         fulBnbHk6nI1z+KEDQVYwuXz3vg9vvlMZuDBm60mvAHxVxmiHAaXVYsHREDOKWfDgkRP
         4OX24fchdF5eAppQGXTXDOMF3lbC1N/HnbHVnsTHaGdfhLFiZ9EqJ8qVksLN/yzuOvyo
         QIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZsaJ/52U7cZLmE6ctPyXK8XUe33/stjG8THMIu6wVGU=;
        b=n9feaSeLu7xkojB/n3dCfCcDNCAywuWpCqzBQtEtsBd3MF+bAo+dL1s9vXTnnX41T8
         iP58HATePCm0qjAc5PtiShz26DK91IprgaOEtmeKJ/FoiGNoLz4u2SX+FgNUfIi4AahQ
         NEFcEQUD6s9IHuOjqJWefgsjoJtIPUVItt3JxVbFGhpcGs5JfP8/oVzP8/gx6j/RUP3+
         phe8OEfBtjga224DwLB7WYEv8ADztwvyoEZZb8NPLrN1J9iNxVeng74c5aa9zzfxksdx
         j6YzLvAEm0VRViCcg/RIyrbEPUMF3jpDffh+hAbC8/JGd6CyQBPMLhJiTS7hH0iCtpli
         CKPA==
X-Gm-Message-State: AOAM533sMLDLqIOQejTSRz1LXC102fFB8I9rukRI8PNueC7gm5Tknvc6
        uat9Q3/Wom/Bi2r2dtfC7IFbWGcgdbMvJHieCRxF4RYKUPk=
X-Google-Smtp-Source: ABdhPJwk+ekDMb1/Vp1di+Fw3CVEgfEyZGbPeNiKh55+gY80alFolcT8I6MhKqljhmb9I5u8VpxFy8JukZM0L4u3+Nk=
X-Received: by 2002:a2e:954:0:b0:241:73c:cb5e with SMTP id 81-20020a2e0954000000b00241073ccb5emr6619311ljj.86.1645202363662;
 Fri, 18 Feb 2022 08:39:23 -0800 (PST)
MIME-Version: 1.0
References: <20220217094802.3644569-1-bigeasy@linutronix.de> <20220217094802.3644569-3-bigeasy@linutronix.de>
In-Reply-To: <20220217094802.3644569-3-bigeasy@linutronix.de>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 18 Feb 2022 08:39:12 -0800
Message-ID: <CALvZod7Jz91+px=Gpmd8qeY=eN1tS6vEGK0Dq_eGNq9Q=pj7xQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm/memcg: Disable threshold event handlers on PREEMPT_RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 17, 2022 at 1:48 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> During the integration of PREEMPT_RT support, the code flow around
> memcg_check_events() resulted in `twisted code'. Moving the code around
> and avoiding then would then lead to an additional local-irq-save
> section within memcg_check_events(). While looking better, it adds a
> local-irq-save section to code flow which is usually within an
> local-irq-off block on non-PREEMPT_RT configurations.
>
> The threshold event handler is a deprecated memcg v1 feature. Instead of
> trying to get it to work under PREEMPT_RT just disable it. There should
> be no users on PREEMPT_RT. From that perspective it makes even less
> sense to get it to work under PREEMPT_RT while having zero users.
>
> Make memory.soft_limit_in_bytes and cgroup.event_control return
> -EOPNOTSUPP on PREEMPT_RT. Make an empty memcg_check_events() and
> memcg_write_event_control() which return only -EOPNOTSUPP on PREEMPT_RT.
> Document that the two knobs are disabled on PREEMPT_RT.
>
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
