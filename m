Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6440D7A002
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2019 06:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfG3E0W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Jul 2019 00:26:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43546 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfG3E0W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Jul 2019 00:26:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so29129934pfg.10
        for <cgroups@vger.kernel.org>; Mon, 29 Jul 2019 21:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+uAEwHCS/q5YqbTZfM9UhcffVFTLKHWKlvMKu9AlaN4=;
        b=EsXmEMrAKLXYhP9zY31O+/h2ZdkuRU0uxUsvt12z/dYH/onDFgVEw8/psz+asNdBYU
         nFXBcaiag1L68Tv6zpHm7dfIu0NIX/b28PPUvE9EqMHFn//8WEUWABDEeEqYk5Fghedc
         pEQppssDC1/AlpgweEINkqIDwRAPLQbsEmQA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+uAEwHCS/q5YqbTZfM9UhcffVFTLKHWKlvMKu9AlaN4=;
        b=tWdiibqqFX1BkPfpTrrJsOSM+WVhAOB0jtsMl9axk0s3lvz2nqwozbHk1qdCGlFAFr
         SvB42LbQFQvxVWI8i3m0LMNuhHsCmmu0Yw8n3KuQH7isfWONu4jSsA0uTECI6LcwrltJ
         ++10rK4MGw+dRfmY6Cz+6D29TL3xoPTrHOvcXv7BoFHFUl6pZQ6UCO6gshhhrPomx9gn
         42aN6awNs4Dkm6rZ1zJeoLV6EVKy8/f+IT81nIGE78YfrL6phP26DJ9oXM/F0FDJwBxV
         ee0QerQqKqrJWenrnZsssR7/HBJ6+Rhw/2J1/g40NMxSdohy6hcnHoPaZFjzm1T00At8
         58Cg==
X-Gm-Message-State: APjAAAWVnbOePJbeInif8zUhoYgYpVN1KygA6SNWc5pTIqx44xoWhe32
        YSx+fIzrVODhRf7xO6eFMa1FRQ==
X-Google-Smtp-Source: APXvYqw2DLcYsS+Y/kRsFOifnzk248iODzBuup35eBpVU/fNRfatgN+BuHFV6EhGR/gtK8Sdcr0WOg==
X-Received: by 2002:a62:174a:: with SMTP id 71mr41180815pfx.140.1564460781249;
        Mon, 29 Jul 2019 21:26:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w22sm67693578pfi.175.2019.07.29.21.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 21:26:20 -0700 (PDT)
Date:   Mon, 29 Jul 2019 21:26:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Laura Abbott <labbott@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 01/12] rdmacg: Replace strncmp with str_has_prefix
Message-ID: <201907292117.DA40CA7D@keescook>
References: <20190729151346.9280-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729151346.9280-1-hslester96@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 29, 2019 at 11:13:46PM +0800, Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone.
> We had better use newly introduced
> str_has_prefix() instead of it.

Wait, stop. :) After Laura called my attention to your conversion series,
mpe pointed out that str_has_prefix() is almost redundant to strstarts()
(from 2009), and the latter has many more users. Let's fix strstarts()
match str_has_prefix()'s return behavior (all the existing callers are
doing boolean tests, so the change in return value won't matter), and
then we can continue with this replacement. (And add some documentation
to Documenation/process/deprecated.rst along with a checkpatch.pl test
maybe too?)

Actually I'd focus first on the actually broken cases first (sizeof()
without the "-1", etc):

$ git grep strncmp.*sizeof | grep -v -- '-' | wc -l
17

I expect the "copy/paste" changes could just be a Coccinelle script that
Linus could run to fix all the cases (and should be added to the kernel
source's list of Coccinelle scripts). Especially since the bulk of the
usage pattern are doing literals like this:

arch/alpha/kernel/setup.c:   if (strncmp(p, "mem=", 4) == 0) {

$ git grep -E 'strncmp.*(sizeof|, *[0-9]*)' | wc -l
2565

And some cases are weirdly backwards:

tools/perf/util/callchain.c:  if (!strncmp(tok, "none", strlen(tok))) {

-Kees

> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  kernel/cgroup/rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
> index ae042c347c64..fd12a227f8e4 100644
> --- a/kernel/cgroup/rdma.c
> +++ b/kernel/cgroup/rdma.c
> @@ -379,7 +379,7 @@ static int parse_resource(char *c, int *intval)
>  			return -EINVAL;
>  		return i;
>  	}
> -	if (strncmp(value, RDMACG_MAX_STR, len) == 0) {
> +	if (str_has_prefix(value, RDMACG_MAX_STR)) {
>  		*intval = S32_MAX;
>  		return i;
>  	}
> -- 
> 2.20.1
> 

-- 
Kees Cook
