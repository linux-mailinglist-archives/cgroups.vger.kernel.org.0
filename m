Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5427EE54
	for <lists+cgroups@lfdr.de>; Wed, 30 Sep 2020 18:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgI3QG0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Sep 2020 12:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731085AbgI3QGW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Sep 2020 12:06:22 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4103BC061755
        for <cgroups@vger.kernel.org>; Wed, 30 Sep 2020 09:06:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d20so1929624qka.5
        for <cgroups@vger.kernel.org>; Wed, 30 Sep 2020 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=g41JLhfIKA5K1F27QDDdvv1oI3KqFYKZHQkgtQyVAXo=;
        b=e1WuNmpdxD/QTKyw5jxyEPOYd107hD90v0l2i9jSavalJ6nSmBdIbYYOojNZ+OZlVJ
         W/Fa7jy8cHZbwkS6qwSZi8JEy6XFTbp2qe212vp1n9NQbIJ/NfuVusUrw+BcNmgqOHuU
         Ftc8Ek7DLuTEqbQir4OLNOajOhc2Cy6lKc2R1hg4Ru0lg1LS9NL73H0JQEJgX4mCX+ns
         hbVlNiCBdGA7VJ9T5fTT2Xd16ffiLbrCB8s4CaaMHWuNVwtGGuMQhv0b5WGqiwMZgsW+
         Jmw9OBN9QT42t4cwk9sU967SOqT6Sff6Wr4nmFm8MazL4rijQvZ8LKJ//sepOeCp4r0R
         lHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=g41JLhfIKA5K1F27QDDdvv1oI3KqFYKZHQkgtQyVAXo=;
        b=OTHJhngOz5US60Gbuv4dcrhSOvWuxcPnH3AGF/4+CfHMx4y9ogRO4TxTGlvH6Y2jyM
         7QU+FgXLm6BniOB7JVposwTCG+LdAz2HuoodeyRO+sWe6WRW6A+oONCL6qGjxpzkEr4j
         c3atmE4w8F38tojzXF7hq5Eg2voBMsqBfDD5mEbOptP9hgBMd6QXJwbhUmdJKGzsbAE8
         tTUVomTYU/aaKNjecUCFsWc9Xb7rr05iF+b7jsNmifjv5a/tv1Z7mPvt8Y0ZetlQd+x1
         nZg59odeNKaiFveLZsZnuGZLwWSa7PequJ/3nI+hxXWeKbsI7stsmHIWLlA50wGb0kA6
         h2KQ==
X-Gm-Message-State: AOAM531BzJl0ASxpRQGsBWB1Ej1WaJfREYgg3tqDDWPvZO243AM3A31v
        KjNa1TYD8HzKc8+P56ahzsE=
X-Google-Smtp-Source: ABdhPJwBrcqU3UA8h5o1rZTqPwV6zJT7v79FIgLeBQVUTJDh/AlXqTzGZH2bkhaq3AWMFQ7LcQ0XVA==
X-Received: by 2002:a37:4015:: with SMTP id n21mr1573749qka.212.1601481981392;
        Wed, 30 Sep 2020 09:06:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e9fa])
        by smtp.gmail.com with ESMTPSA id l25sm3124341qtf.18.2020.09.30.09.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 09:06:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Sep 2020 12:06:19 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Jouni Roivas <jouni.roivas@tuxera.com>, lizefan@huawei.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: Zero sized write should be no-op
Message-ID: <20200930160619.GE4441@mtj.duckdns.org>
References: <20200928131013.3816044-1-jouni.roivas@tuxera.com>
 <20200930160357.GA25838@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930160357.GA25838@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Sep 30, 2020 at 06:03:57PM +0200, Michal Koutný wrote:
> On Mon, Sep 28, 2020 at 04:10:13PM +0300, Jouni Roivas <jouni.roivas@tuxera.com> wrote:
> > Do not report failure on zero sized writes, and handle them as no-op.
> This is a user visible change (in the case of a single write(2)), OTOH,
> `man write` says:
> > If count is zero and fd refers to a file other than a regular file,
> > the results are not specified.

So, I'm not necessarily against the change, mostly in the spirit of "why
not?".

> > @@ -3682,6 +3700,9 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
> >  	struct cgroup_subsys_state *css;
> >  	int ret;
> >  
> > +	if (!nbytes)
> > +		return 0;
> > +
> >  	/*
> >  	 * If namespaces are delegation boundaries, disallow writes to
> >  	 * files in an non-init namespace root from inside the namespace
> Shouldn't just this guard be sufficient? 

But yeah, please do it in one spot.

Thanks.

-- 
tejun
