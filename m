Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143DC76D91A
	for <lists+cgroups@lfdr.de>; Wed,  2 Aug 2023 23:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjHBVCC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Aug 2023 17:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjHBVCB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Aug 2023 17:02:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5451E4F;
        Wed,  2 Aug 2023 14:01:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc3d94d40fso2592155ad.3;
        Wed, 02 Aug 2023 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691010119; x=1691614919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5eoW13Er2byi3F5AVWdPVCJvLFofz+zD3HXMr0r2JM=;
        b=P1bVrDOw/XQIdFJy0p0oko56FRhKc/+1jthxROevZRwecRH5Uht2TndqyzxXrGGMog
         7/30DAYMILosXblR2uDbNqmfTJrJMBW568BcowS8vvbiHkiYdm130TChDOkV8z2pXcMs
         JIQa7odjTt+Hxyp0rxDAR4JkZ68MimCN76/dauJ6lareMIriz1fgAKe/SjYkFD9foGyk
         RufJNhvEQAOyBDZciJv+71xUTQgxVCkM9UKYs4VDR4ZbVvgFgnbLsUdnW8PCp73IgO3Z
         188Gk8UPI+WKN3h4oIfAgFSkQZ2mK/9lQRZpLS9Xo5/AK5XjzeLp31hGu5CfFmzyVgKt
         ryiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691010119; x=1691614919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5eoW13Er2byi3F5AVWdPVCJvLFofz+zD3HXMr0r2JM=;
        b=gCdL3iq1/AbTCzlKMY/dWahKtuxwYyD8jF3ROLrJ6eaxY2sfrAkUZ8qGEypaM0zWCH
         4HcqBFpcjfnH+OQ6UKjq1tL6Umqa4Jat3GLc+HJEV5G+auxwTl43Ol123GsoR0TXyp92
         sH5CamxZyZj3Xjcf29O/ycvqixRf1Avm5yr0ZxWw5xeUe7JroK6VdFQhKEBJj1AyM7ic
         9DlgXKXYlajDXLynuWIApXfnf5t+2iDs9GgnTue2t5aZSLsYFIDpmx6m7YAWSMSkB+ei
         0dvpXGRRSGNK536LuGsuPxL64Mdlk7xY19+Y3xwFUIEea5+loT9Nua8c23XMVTd4zpW/
         KXuA==
X-Gm-Message-State: ABy/qLZyPRAdVPf/FrkpXsen4akUk1sRt57wNPdGbj7i1P4BW7xNHpjN
        7heCaf8Sjj4DPobBY1JSdlMS9ovsmyM=
X-Google-Smtp-Source: APBJJlHKOmx4rPr7kbwyaqtRbGAy+Uc0YS+OodbIRX4oI5TwcwnzsjZarxKt+MJcjl9FlZnTJJ7/xw==
X-Received: by 2002:a17:902:7486:b0:1bc:5d0:e8db with SMTP id h6-20020a170902748600b001bc05d0e8dbmr12291661pll.62.1691010118975;
        Wed, 02 Aug 2023 14:01:58 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001a5260a6e6csm12878628plb.206.2023.08.02.14.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 14:01:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Aug 2023 11:01:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v5 4/5] cgroup/cpuset: Documentation update for partition
Message-ID: <ZMrERWeIeEOGzXHO@slm.duckdns.org>
References: <20230713172601.3285847-1-longman@redhat.com>
 <20230713172601.3285847-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713172601.3285847-5-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Waiman.

On Thu, Jul 13, 2023 at 01:26:00PM -0400, Waiman Long wrote:
...
> +	When a valid partition is created, the value of this file will
> +	be automatically set to the largest subset of "cpuset.cpus"
> +	that can be granted for exclusive access from its parent if
> +	its value isn't explicitly set before.
> +
> +	Users can also manually set it to a value that is different from
> +	"cpuset.cpus".	In this case, its value becomes invariant and
> +	may no longer reflect the effective value that is being used
> +	to create a valid partition if some dependent cpuset control
> +	files are modified.
> +
> +	There are constraints on what values are acceptable to this
> +	control file.  If a null string is provided, it will invalidate a
> +	valid partition root and reset its invariant state.  Otherwise,
> +	its value must be a subset of the cgroup's "cpuset.cpus" value
> +	and the parent cgroup's "cpuset.cpus.exclusive" value.

As I wrote before, the hidden state really bothers me. This is fine when
there is one person configuring the system, but working with automated
management and monitoring tools can be really confusing at scale when there
are hidden states like this as there's no way to determine the current state
by looking at what's visible at the interface level.

Can't we do something like the following?

* cpuset.cpus.exclusive can be set to any possible cpus. While I'm not
  completely against failing certain writes (e.g. siblings having
  overlapping masks is never correct or useful), expanding that to
  hierarchical checking quickly gets into trouble around what happens when
  an ancestor retracts a CPU.

  I don't think it makes sense to reject writes if the applied rules can't
  be invariants for the same reason given for avoiding hidden states - the
  system can be managed by multiple agents at different delegation levels.
  One layer changing resource configuration shouldn't affect the success or
  failure of configuration operations in other layers.

* cpuset.cpus.exclusive.effective shows what's currently available for
  exclusive usage - ie. what'd be used for a partition if the cgroup is to
  become a partition at that point.

  This, I think, gets rid of the need for the hidden states. If .exclusive
  of a child of a partition is empty, its .exclusive.effective can show all
  the CPUs allowed in it. If .exclusive is set then, .exclusive.effective
  shows the available subset.

What do you think?

Thanks.

-- 
tejun
