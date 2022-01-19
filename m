Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F94493D69
	for <lists+cgroups@lfdr.de>; Wed, 19 Jan 2022 16:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355830AbiASPlb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Jan 2022 10:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355529AbiASPla (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Jan 2022 10:41:30 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC3BC061574;
        Wed, 19 Jan 2022 07:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=pxPDysxsLzRS9m3h8MM0+hZnUy5KDuxOZAnHkZ+LiUU=; b=P6ZwT2AKXUwgwui+4YXZ3+S5JB
        aHNGnZbcF7P0JjQ2N9a3uww5zTv3szmJXvjflxI/R9cm4iHHtjkTZlZZnN7sPr7B+1C6nCW3p0fqX
        DYFOssgLzTGUjKwS6687wmMBof+9C3nc7L2X+Ie0WIui7iCrANpuwmi9xVW2ufFYlQIuY4UQusx9I
        aK7D6KPidQ0p0zcs86E7CjnpH2pWzCpNCPEf30CwVb0ikL3hGDBb+Iqwm4CoClWea/Kn28LragZYK
        sr7sXjUvS/ffkG8+oNECDa6fOeeafsWYlPwh6Kmn96xrLnm5RgXLjTPl+64wXXpx/WxZoNk1VVkXg
        ++56dLGA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAD4n-0026rA-0b; Wed, 19 Jan 2022 15:40:45 +0000
Message-ID: <aea5b741-c994-4007-156e-d8a3a5b9bbcc@infradead.org>
Date:   Wed, 19 Jan 2022 07:40:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC 2/6] cgroup: gpu: Add a cgroup controller for allocator
 attribution of GPU memory
Content-Language: en-US
To:     Hridya Valsaraju <hridya@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Airlie <airlied@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Li Li <dualli@google.com>, Marco Ballesio <balejs@google.com>,
        Hang Lu <hangl@codeaurora.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Vipin Sharma <vipinsh@google.com>,
        Chris Down <chris@chrisdown.name>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org
Cc:     Kenny.Ho@amd.com, daniels@collabora.com, kaleshsingh@google.com,
        tjmercier@google.com
References: <20220115010622.3185921-1-hridya@google.com>
 <20220115010622.3185921-3-hridya@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220115010622.3185921-3-hridya@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi--

On 1/14/22 17:06, Hridya Valsaraju wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index cd23faa163d1..408910b21387 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -990,6 +990,13 @@ config BLK_CGROUP
>  
>  	See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
>  
> +config CGROUP_GPU
> +       bool "gpu cgroup controller (EXPERIMENTAL)"
> +       select PAGE_COUNTER
> +       help
> +	Provides accounting and limit setting for memory allocations by the GPU
> +	and GPU-related subsystems.

Please follow coding-style for Kconfig files:

(from Documentation/process/coding-style.rst, section 10):

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.


thanks.

-- 
~Randy
