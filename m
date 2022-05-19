Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAAD52CC57
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 09:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiESHCM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Thu, 19 May 2022 03:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiESHCJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 03:02:09 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970C9B8BD5;
        Thu, 19 May 2022 00:02:06 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id i68so2890996qke.11;
        Thu, 19 May 2022 00:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Lduo9otIskPj76nIDF1xXbuoAxPQZ4aqYfqX6zq4mc=;
        b=sAAnsJIApG/ZwL0wpmvzxokrqGsn1cW0nL/+UFqj52FWNiBMy4X+65JmGsHtQ8SprY
         Q6IVSqzRUkFbphaFocyoK8/71FH27BR5SztJDj9w7PN7WaxJISZsr083N+NXQY6WGA+3
         WAMrDapEhqMq2Pcf4bqRZ0lpXc4SBEkj0K7zvNMPFhubKs05NqcP8PIirs72uIRPnvO1
         QZL0v3Zfbe6mlT596xAQr7X7gw6im0qfOvw/xzw764U/ueIo4JL/VOXEvoNp37CVyhEV
         s4ISuJhN4BBSmXtBfBI1KWIKRkG67SdotGT/LLZmOIip9RlbTnrKFDDU468N7kdHIYhi
         bVPw==
X-Gm-Message-State: AOAM53150UhSZezsMQtDcauWiE4lmiCSD647awQ91k89cpnq7ZYsdqxG
        4n8pIZH6U203Dl3Q3ZarWkoF0GwKb2wzfw==
X-Google-Smtp-Source: ABdhPJx9gBig7pcOCKHOYGAsUW3SWXtrLvHKl5FB6r2Ru6VzcjT8AwYxPsr4jxQOEXq6hf1I4V8kjA==
X-Received: by 2002:a37:a492:0:b0:6a3:2a8a:530 with SMTP id n140-20020a37a492000000b006a32a8a0530mr2145443qke.552.1652943725573;
        Thu, 19 May 2022 00:02:05 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id c64-20020a379a43000000b0069fc13ce212sm883701qke.67.2022.05.19.00.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 00:02:05 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id t26so7475907ybt.3;
        Thu, 19 May 2022 00:02:04 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr3068334ybu.604.1652943724521; Thu, 19
 May 2022 00:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220518072751.1188163-3-yukuai3@huawei.com> <202205182347.tMOOqyfL-lkp@intel.com>
 <84fe296e-6e56-3ca9-73a8-357beb675c6e@huawei.com> <3d6878f4-1902-633d-0af2-276831364a4f@huawei.com>
In-Reply-To: <3d6878f4-1902-633d-0af2-276831364a4f@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 May 2022 09:01:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV6NysKKh+HZ-cgHh+=SVcydmxO6ic82+t3ySTgfkoEOg@mail.gmail.com>
Message-ID: <CAMuHMdV6NysKKh+HZ-cgHh+=SVcydmxO6ic82+t3ySTgfkoEOg@mail.gmail.com>
Subject: Re: [PATCH -next v2 2/2] blk-throttle: fix io hung due to
 configuration updates
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     kernel test robot <lkp@intel.com>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        kbuild-all@lists.01.org, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Yukuai,

On Thu, May 19, 2022 at 5:25 AM yukuai (C) <yukuai3@huawei.com> wrote:
> 在 2022/05/19 10:11, yukuai (C) 写道:
> > 在 2022/05/18 23:52, kernel test robot 写道:
> >> Thank you for the patch! Yet something to improve:
> >>
> >> [auto build test ERROR on next-20220517]
> >>
> >> url:
> >> https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/bugfix-for-blk-throttle/20220518-151713
> >>
> >> base:    47c1c54d1bcd0a69a56b49473bc20f17b70e5242
> >> config: m68k-allyesconfig
> >> (https://download.01.org/0day-ci/archive/20220518/202205182347.tMOOqyfL-lkp@intel.com/config)
> >>
> >> compiler: m68k-linux-gcc (GCC) 11.3.0
> >> reproduce (this is a W=1 build):
> >>          wget
> >> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> >> -O ~/bin/make.cross
> >>          chmod +x ~/bin/make.cross
> >>          #
> >> https://github.com/intel-lab-lkp/linux/commit/f8345dbaf4ed491742aab29834aff66b4930c087
> >>
> >>          git remote add linux-review
> >> https://github.com/intel-lab-lkp/linux
> >>          git fetch --no-tags linux-review
> >> Yu-Kuai/bugfix-for-blk-throttle/20220518-151713
> >>          git checkout f8345dbaf4ed491742aab29834aff66b4930c087
> >>          # save the config file
> >>          mkdir build_dir && cp config build_dir/.config
> >>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0
> >> make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>     m68k-linux-ld: block/blk-throttle.o: in function `tg_conf_updated':
> >>>> blk-throttle.c:(.text+0x25bc): undefined reference to `__udivdi3'
> >>>> m68k-linux-ld: blk-throttle.c:(.text+0x2626): undefined reference to
> >>>> `__udivdi3'
> > Hi,
> >
> > I'm confused here, the only place that I can relate to this:
> >
> >      return dispatched * new_limit / old_limit;
> >
> > However, I don't understand yet why this is problematic...
> >>     `.exit.text' referenced in section `.data' of
> >> sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section
> >> `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o
>
> + static u64 throtl_update_bytes_disp(u64 dispatched, u64 new_limit,
> +                                    u64 old_limit)
> + {
> +        if (new_limit == old_limit)
> +                return dispatched;
> +
> +        if (new_limit == U64_MAX)
> +                return 0;
> +
> +        return dispatched * new_limit / old_limit;
>
> I understand it now. I'm doing (u64 / u64), I should use div64_u64

Better, use mul_u64_u64_div_u64(), as "dispatched * new_limit"
may overflow?

> + }
> +
> + static u32 throtl_update_io_disp(u32 dispatched, u32 new_limit, u32 old_limit)
> + {
> +        if (new_limit == old_limit)
> +                return dispatched;
> +
> +        if (new_limit == UINT_MAX)
> +                return 0;
> +
> +        return dispatched * new_limit / old_limit;

This is the same as above, but now operating on u32s instead of u64s.
Likewise, can the multiplication overflow?

> + }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
