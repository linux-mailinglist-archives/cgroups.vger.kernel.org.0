Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DDC53B1E8
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 05:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiFBDGp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 23:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiFBDGn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 23:06:43 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C422233EB7
        for <cgroups@vger.kernel.org>; Wed,  1 Jun 2022 20:06:42 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 129so3616823pgc.2
        for <cgroups@vger.kernel.org>; Wed, 01 Jun 2022 20:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2wNLI+UiPxMD8gpYb8X0rEwvSxrz6cSA2s7fFzdJJpo=;
        b=U7mxsOuX6jlRQc/N2wDNPLldG8N8Q//HPEH8MZkAnJQTYBblNNDA6fvJcYZa2+ajhu
         r7v8owfFW4WH9wCmj4KA9V7eXigowV+GwmRcRsY/bmS96PzTs2Y4LN+gvpOvNDeyWh6g
         GXxB6XFIimI5GljV7sKZpmyYYoAHvuFXHsvc5wRHpAnt/h4J44rLOBoDqGvTKwjXY9lN
         lA8WlNUJq4AZRgtThcD+jnB/opVPFJ1f7MmsBfaOgQu1AJyDo5hFyWPpGqzd6wvSo2PF
         14kSrZTDwtXro5yUWNjjwaUt5ut8ETmbwzfNA0W6I4LXQ0KDtbjiiWhgeGQqHGOw8UOM
         KM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2wNLI+UiPxMD8gpYb8X0rEwvSxrz6cSA2s7fFzdJJpo=;
        b=tjZpa6Q5zIALq8YbJSVVJsq2QZnQaFn7E9q2OGl9SHE6XWVtrN7EKjJGNn2/FhuXNy
         pWYW1MoAuvoLlEExys3n+z0hha3YJKnXHLEwJsDCo+VbJnwbNDwziudfZWxc/9QJ1Wxr
         /K11V8Op4jCz32rTJQU/9ImiJN1ABkoWgjlkGGxjd6Eti5xLNqOk6jmaZx2nx1kvJmA7
         ncbxKZmV3oqywIes59FeTttS2lXIMfgROS+uJ0M8VHPxRntO0+TeT8PgDWhfjXpW7vm6
         17xZ1u51M38UhGSQu0vV8f16XcKvaKlAEkm7TnD3opVj1Rc99jz+ELmmifsc2hBPXBWp
         sLkw==
X-Gm-Message-State: AOAM532VFMDffWZzsY018amit8VCrVNFG4ZlROZUkeSphYscV9EG7WXS
        SUhnGt1T8cW/0F3LrEuC2MEfZQ==
X-Google-Smtp-Source: ABdhPJyCOcJbpRbXJqeVRd/304cyIed9Z6+PjPA9f74qJZ36s3xgnk3oFV7hWHEbHUgOVebZGcEixg==
X-Received: by 2002:a63:db47:0:b0:3fc:17e5:9fbb with SMTP id x7-20020a63db47000000b003fc17e59fbbmr2215874pgi.504.1654139201494;
        Wed, 01 Jun 2022 20:06:41 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:2468:2a68:7bbe:680c])
        by smtp.gmail.com with ESMTPSA id s16-20020aa78bd0000000b0051bbd79fc9csm960267pfd.57.2022.06.01.20.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 20:06:41 -0700 (PDT)
Date:   Thu, 2 Jun 2022 11:06:35 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v5 03/11] mm: memcontrol: prepare objcg API for non-kmem
 usage
Message-ID: <YpgpOxzxNzbN26mr@FVFYT0MHHV2J.googleapis.com>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-4-songmuchun@bytedance.com>
 <20220601173434.GB16134@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220601173434.GB16134@blackbody.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 01, 2022 at 07:34:34PM +0200, Michal Koutný wrote:
> Hello.
> 
> On Mon, May 30, 2022 at 03:49:11PM +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> > So we also allocate an object cgroup for the root_mem_cgroup.
> 
> This change made me wary that this patch also kmem charging in the
> root_mem_cgroup. Fortunately, get_obj_cgroup_from_current won't return

Sorry for the confusing.  Right, we don't charge kmem to the root objcg.

> this objcg so all is fine.
> 
> > +}
> > +#else
> > +static inline void obj_cgroup_release_bytes(struct obj_cgroup *objcg)
> > +{
> > +}
> > +#endif
> 
> This empty body is for !CONFIG_MEMCG_KMEM, however, the subsequent use for LRU
> pages makes no use of these, so it's warranted.
> 
> Altogether, I find this correct, hence
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
>

Thanks Michal.

