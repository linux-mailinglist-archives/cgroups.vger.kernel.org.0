Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B399E1A4AF9
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2020 22:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJUSM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Apr 2020 16:18:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38003 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJUSM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Apr 2020 16:18:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so2921573wrp.5;
        Fri, 10 Apr 2020 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LirB/PVqDgbE/D2KaEucIjmXEfNOl2FdUxp75VSmgWE=;
        b=S053X/y+NH90mhlB5TvqX63DVsl/Lc1yRGm0DWqWlZImLn+KezB6cOWo6TWueeZ8IG
         4SIf90nikPeanX9PTUHmFwwDP8X9SqfBKH/o/lycd7pixNk/nQPr//+IFLLbynFNlbm9
         M39etzBJ9gWDsxJ3qNI8p+i3QNY6C0gZfEsJrgvM4ofhOZt+fvAAu0P/Nq6V7zOv05kz
         An5152US6IlZbufK6mSq9CyVe/iRwJvNVTUX0KRENF1D+Xj4YHq9G8lm5CpjLzGaJjmj
         PJX3VbPrP4P87dDLht6loOfdfEgjL4y1AjNK4gi6eZDbYWB5wtIGr6nzu/hYqYRMC66t
         XKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LirB/PVqDgbE/D2KaEucIjmXEfNOl2FdUxp75VSmgWE=;
        b=D+Dkhv4jqY0mGuWy7i97oq2pX8KAXk5W6z0PmgOkHIBG72PgLq5tB1+M4fbXfD9FEk
         lC4fkkySG7Cj+QtYv0iDNB7AJNYwXhawiYWQnDGQjF/gVm/rBcVwhvSq2yGoUDnqBtMU
         c0AWWJ9bkTP1evsyD65QVso4tNsPWBKLV+7eHklPB3YTi+OWdtVdSGqfF8JMTXrseNxo
         XVNWbbPTNwTTkMliyvtf5fnXCIIeg+QCY6ZRthMCVyOJpXJOrX1ALmES7XCSmXSUpcnV
         lSkf0NPjwMPYzHsbDw04AmWkb+JimHN6bb9htPPX94rpNZGY45DpCoeMpg0J8kK6CzS3
         +NHA==
X-Gm-Message-State: AGi0PuZJrBLyPoXHo/S9E853ifkXNOFP+1vZfyEYnENx4Ba88jewVPZR
        rwP8ed8WvC7ivfGcInHfURt8VwHP
X-Google-Smtp-Source: APiQypJJZOIPvHdzHvYIayF6B94aL6PrGar63+56dmk6qwKH1KDDM4ArCh3MtMFvbv9cYkRH/qqWZw==
X-Received: by 2002:adf:e744:: with SMTP id c4mr5867370wrn.133.1586549889297;
        Fri, 10 Apr 2020 13:18:09 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id a7sm4085832wmj.12.2020.04.10.13.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 13:18:08 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, cgroups@vger.kernel.org,
        christian.brauner@ubuntu.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        oleg@redhat.com, tj@kernel.org
Subject: Re: [PATCH] clone.2: Document CLONE_INTO_CGROUP
To:     Christian Brauner <christian@brauner.io>
References: <CAKgNAkhL0zCj11LS9vfae872YVeRsxdz20sZWuXdi+UjH21=0g@mail.gmail.com>
 <20200410104132.294639-1-christian@brauner.io>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <b7550fcd-ba12-e64a-3228-e6668b31a8a7@gmail.com>
Date:   Fri, 10 Apr 2020 22:18:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410104132.294639-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Christian,

Thank you for writing this!

On 4/10/20 12:41 PM, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  man2/clone.2 | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/man2/clone.2 b/man2/clone.2
> index 39cec4c86..8d9aa9f99 100644
> --- a/man2/clone.2
> +++ b/man2/clone.2
> @@ -197,6 +197,7 @@ struct clone_args {
>      u64 tls;          /* Location of new TLS */
>      u64 set_tid;      /* Pointer to a \fIpid_t\fP array */
>      u64 set_tid_size; /* Number of elements in \fIset_tid\fP */
> +    u64 cgroup;       /* Target cgroup file descriptor for the child process */
>  };
>  .EE
>  .in
> @@ -448,6 +449,25 @@ Specifying this flag together with
>  .B CLONE_SIGHAND
>  is nonsensical and disallowed.
>  .TP
> +.BR CLONE_INTO_CGROUP " (since Linux 5.7)"
> +.\" commit ef2c41cf38a7559bbf91af42d5b6a4429db8fc68
> +By default, the child process will belong to the same cgroup as its parent.

s/belong to/be placed in/

s/cgroup/version 2 cgroup/

> +If this flag is specified the child process will be created in a
> +different cgroup than its parent.
> +
> +When using
> +.RB clone3 ()
> +the target cgroup can be specified by setting the
> +.I cl_args.cgroup
> +member to the file descriptor of the target cgroup. The cgroup file

We need to say something about how this file descriptor is
obtained. Is it by opening a directory in the v2 cgroup hierarchy?
With what flags? O_RDONLY? or is O_PATH also possible? Yes, these
are some rhetorical questions (I read your nice commit message);
these things need to be explicit in the manual page though.

Also, your commit message mentions a nice list of use cases.
I think it would be well worth capturing those in a paragraph
in the manual page text.

> +descriptor must refer to a cgroup in a cgroup v2 hierarchy
> +(see
> +.BR cgroup (2)).

s/cgroup/cgroups/
s/2/7/

> +
> +Note that all usual cgroup v2 process migration restrictions apply. See
> +.BR cgroup (2)

s/cgroup/cgroups/
s/2/7/

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
