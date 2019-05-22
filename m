Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF18827228
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2019 00:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfEVWSp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 May 2019 18:18:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44991 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfEVWSp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 May 2019 18:18:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id c5so1721924pll.11
        for <cgroups@vger.kernel.org>; Wed, 22 May 2019 15:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QUdAmGAks4E+4DtrN0mw6crQFbwVYGBopZMl7vlB5xU=;
        b=gnPu95pB76Hc4txzz6BDi48JQGwlBKlryzlDHuG/n0DhE+ubr+d43v3d4CVQQARDfv
         rDONLYaYKQ8KqJ9i++TTN0BPf98fY37iG3zfc6/oSlvf6rd3PoVUGcLZ+qk5MujPnyHx
         kGbxwb6lScVthKUY9+NLiUOuf7eI7JIbT0Vyx5A860qAlECkU6+LM3bqn/pAj4MZ7srv
         5+I5uMRWrfuHhSKRjjpoUuu2QdfaAe5pQHq6mnpg8lhi8LjhGXP/C0tsx4cyD/1pjA+b
         maDom5+rvbWtufW7OFGn2mS3ghksirusuFNUjDPBn4Vw4BDTtymMKQRTfGPGyPsDtI01
         D+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QUdAmGAks4E+4DtrN0mw6crQFbwVYGBopZMl7vlB5xU=;
        b=VIlPIsGTsU1u2YDH3LTemncFZp8R9eASRg4R8vvPm1rhYI4PgctSzf60/OeMryTx/z
         agWUrLsNuTCn98Kz+ynUUdV0NJ8SJxhW8Em+EZklJOOSITopcI4m0cjeLMiXz27iaURe
         vylWb3VYQIHqkP6vnu/YrfhYkmwMGzPeQTdtW493sylHh+1MlA1zhfI67AYA62Btuv+5
         DTRrLOMKv+c7V1gSp4HeIfLVz964eKbqPSpo+QIljqxCJ3DNZIZBZeX1ffh8kNuVuSsT
         Hmd9K+XZlv4C6MZVX4311LLXZVmYs58f+K6Iy90GmJoL7DLuBQsHsbC6NBvDWMMg08Up
         L3Og==
X-Gm-Message-State: APjAAAVs1yQTfPf2IZk62vdYcQU6nPLgPh4+Sfz48ruy3+72+pExv84E
        Ei0a3db1YXO3R4Mo8bPQSj17qA==
X-Google-Smtp-Source: APXvYqwPSBEYFh3s2/ZKBKXC4f3IrI47OPivC9KwR7cQjypOsdzUYyqv0o0smuB9CZYaU/DwXSGTXA==
X-Received: by 2002:a17:902:b949:: with SMTP id h9mr49158945pls.50.1558563524887;
        Wed, 22 May 2019 15:18:44 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id q14sm26900610pgg.10.2019.05.22.15.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 15:18:44 -0700 (PDT)
Date:   Wed, 22 May 2019 15:18:43 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: enable all available cgroup
 v2 controllers
Message-ID: <20190522221843.GA3032@mini-arch>
References: <20190522212932.2646247-1-guro@fb.com>
 <20190522212932.2646247-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522212932.2646247-4-guro@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 05/22, Roman Gushchin wrote:
> Enable all available cgroup v2 controllers when setting up
> the environment for the bpf kselftests. It's required to properly test
> the bpf prog auto-detach feature. Also it will generally increase
> the code coverage.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  tools/testing/selftests/bpf/cgroup_helpers.c | 58 ++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
> index 6692a40a6979..4533839c0ce0 100644
> --- a/tools/testing/selftests/bpf/cgroup_helpers.c
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.c
> @@ -33,6 +33,61 @@
>  	snprintf(buf, sizeof(buf), "%s%s%s", CGROUP_MOUNT_PATH, \
>  		 CGROUP_WORK_DIR, path)
>  
> +/**
> + * enable_all_controllers() - Enable all available cgroup v2 controllers
> + *
> + * Enable all available cgroup v2 controllers in order to increase
> + * the code coverage.
> + *
> + * If successful, 0 is returned.
> + */
> +int enable_all_controllers(char *cgroup_path)
> +{
> +	char path[PATH_MAX + 1];
> +	char buf[PATH_MAX];
> +	char *c, *c2;
> +	int fd, cfd;
> +	size_t len;
> +
> +	snprintf(path, sizeof(path), "%s/cgroup.controllers", cgroup_path);
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0) {
> +		log_err("Opening cgroup.controllers: %s", path);
> +		return -1;
> +	}
> +
> +	len = read(fd, buf, sizeof(buf) - 1);
> +	if (len < 0) {
> +		close(fd);
> +		log_err("Reading cgroup.controllers: %s", path);
> +		return -1;
> +	}
> +
> +	close(fd);
> +
> +	/* No controllers available? We're probably on cgroup v1. */
> +	if (len == 0)
> +		return 0;
> +
> +	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
> +	cfd = open(path, O_RDWR);
> +	if (cfd < 0) {
> +		log_err("Opening cgroup.subtree_control: %s", path);
> +		return -1;
> +	}
> +

[..]
> +	buf[len] = 0;
nit: move this up a bit? Right after:

	if (len < 0) {
		...
	}
	buf[len] = 0;
	close(fd);

I was actually writing a comment about missing buf[len]=0 until I
somehow spotted it :-)

> +	for (c = strtok_r(buf, " ", &c2); c; c = strtok_r(NULL, " ", &c2)) {
> +		if (dprintf(cfd, "+%s\n", c) <= 0) {
> +			log_err("Enabling controller %s: %s", c, path);
> +			close(cfd);
> +			return -1;
> +		}
> +	}
> +	close(cfd);
> +	return 0;
> +}
> +
>  /**
>   * setup_cgroup_environment() - Setup the cgroup environment
>   *
> @@ -71,6 +126,9 @@ int setup_cgroup_environment(void)
>  		return 1;
>  	}
>  
> +	if (enable_all_controllers(cgroup_workdir))
> +		return 1;
> +
>  	return 0;
>  }
>  
> -- 
> 2.20.1
> 
