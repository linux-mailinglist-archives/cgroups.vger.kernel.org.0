Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4935555CBB5
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiF0JHa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 05:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiF0JHY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 05:07:24 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1B96398;
        Mon, 27 Jun 2022 02:07:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 184so8499066pga.12;
        Mon, 27 Jun 2022 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tRneTDLFQMzVfO2N/gHNDmUeVj26egu5hiaZEE0FtjA=;
        b=fQ6t0azwoBYBWQ8D03hqBSBzPvIyFe3pEoBa6IZz851wn1dYbZd0wh1MP3LHlJrK1Z
         PR26etFEelPHmooDifKqYpWUU2au6IzvThqe7T/W9DIHRtZzh76Gl+aJbsl81IElKp1g
         Xr6UAyqwZDm/OodxwZM5UIxd2tz5aK2ERESgtEinTj0kBv/8fpavsVUfi8Rsqv9ts2zr
         ncCAouqGAx6myEp+eMgvDhtVPZNwQol0xcDdNC7W9qEI9YVLNQJ154N9AIB3kGxtm+fV
         CVRlFohYoB+MOLR5g4J5qiaCzmq6dBpKT+foP0DhKFsDGm3HoQ+jvSJSF5xyzu8rxB6W
         YHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tRneTDLFQMzVfO2N/gHNDmUeVj26egu5hiaZEE0FtjA=;
        b=2+HVaGeblmrvfKQU4BF2350WUu+WPqfW+xMu+Y6JMVAU0qb/kxgp1oJ4Io9aNHxAxV
         W+u/cBugNEFS1iiiCrGO8vqgVODj+G8Lr54505Bt4Jrhn3DIQjsFOboBabY9kkc6qKtG
         dduEqmwSRGgtt+A/g6fJyw+B2UJ6CEdfl9BAafuSLIdpTM66FFDIv6WuNCeBZLDm+kZn
         FA5SO79pEgSSCZrrp3TaBv04yK61yiLwoJlGDLncVOuU8E4RV6JqerSB7PHIW41S0n+z
         NLwwgobkZkCB6WJBgcZD/v9sqSNyAyJG4KSijxUNPu3j9wM4garZpNsgIDQytLu4+iIw
         hshQ==
X-Gm-Message-State: AJIora+RdjWOflFb5cxk5C9q/WJcMZgbxC/cKG+AcUDebpDKCsKprf2w
        NXqvRUvhrmFA1lyi2V+nPPU=
X-Google-Smtp-Source: AGRyM1tfSRVndX1YIfPY/R7kGngBQ/GIQ02B+ypq/d09Iko+wa3RjVqYr5haNhwuwrvCLhik3vADLA==
X-Received: by 2002:a62:1b85:0:b0:525:604d:7dd3 with SMTP id b127-20020a621b85000000b00525604d7dd3mr13781932pfb.4.1656320842802;
        Mon, 27 Jun 2022 02:07:22 -0700 (PDT)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id u12-20020a056a00098c00b00525184bad5csm6752959pfg.63.2022.06.27.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:07:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 27 Jun 2022 18:07:20 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH cgroup] cgroup: set the correct return code if hierarchy
 limits are reached
Message-ID: <YrlzSFkywHthpAZN@mtj.duckdns.org>
References: <186d5b5b-a082-3814-9963-bf57dfe08511@openvz.org>
 <d8a9e9c6-856e-1502-95ac-abf9700ff568@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8a9e9c6-856e-1502-95ac-abf9700ff568@openvz.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 27, 2022 at 05:12:55AM +0300, Vasily Averin wrote:
> When cgroup_mkdir reaches the limits of the cgroup hierarchy, it should
> not return -EAGAIN, but instead react similarly to reaching the global
> limit.

While I'm not necessarily against this change, I find the rationale to
be somewhat lacking. Can you please elaborate why -ENOSPC is the right
one while -EAGAIN is incorrect?

Thanks.

-- 
tejun
